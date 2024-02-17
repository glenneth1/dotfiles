(define-configuration input-buffer
	((override-map
	  (let ((map (make-keymap "override-map")))
		(define-key map
			"C-M-s" 'switch-buffer
			"C-M-t" 'switch-buffer-previous
			"C-M-r" 'switch-buffer-next
            "C-M-o" 'org-capture
			"C-d" 'follow-hint
			"C-M-d" 'follow-hint-new-buffer
			"C-c p" 'copy-password
			"C-c y" 'autofill
			"C-i" :input-edit-mode
			"M-:" 'eval-expression
			"C-s" :search-buffer
			"C-3" 'hsplit
			"C-1" 'close-all-panels
			"C-w" 'delete-current-buffer
			"M-d" 'scroll-up
			"M-s" 'scroll-down
			"M-t" 'history-backwards
			"M-r" 'history-forwards-maybe-query
			"C-c" 'copy
			"C-v" 'paste
			"M-f" 'focus-first-input-field
			)))))



(defun make-google-completion (&key request-args)
  "Helper that generates Google search completion functions. The only
thing that's left to pass to it is REQUEST-ARGS to slightly modify the
request."
  (make-search-completion-function
   :base-url "https://www.google.com/complete/search?q=~a&client=gws-wiz"
   :processing-function
   #'(lambda (results)
       (mapcar (alexandria:compose (alexandria:curry #'str:replace-using '("<b>" "" "</b>" ""))
                                   #'first)
               (first (json:decode-json-from-string
                       (str:replace-first "window.google.ac.h(" "" results)))))
   :request-args request-args))


(defun make-wikipedia-completion (&key (suggestion-limit 10) (namespace :general) request-args)
  "Helper completion function for Wikipedia.
SUGGESTION-LIMIT is how much suggestions you want to get.
NAMESPACE is the Wikipedia-namespace to search in. Acceptable values
are: :general, :talk, :user, :user-talk, :wikipedia, :wikipedia-talk,
:file, :file-talk, :media-wiki, :media-wiki-talk, :template,
:template-talk, :help, :help-talk, :category, and :category-talk.
REQUEST-ARGS are additional request function arguments,
for example '(proxy \"socks5://localhost:9050\") for proxying."
  (make-search-completion-function
   :base-url (str:concat "https://en.wikipedia.org/w/api.php?action=opensearch&format=json&search=~a"
                         (format nil "&limit=~d&namespace=~d"
                                 suggestion-limit
                                 (position namespace (list :general :talk
                                                           :user :user-talk
                                                           :wikipedia :wikipedia-talk
                                                           :file :file-talk
                                                           :media-wiki :media-wiki-talk
                                                           :template :template-talk
                                                           :help :help-talk
                                                           :category :category-talk))))
   :processing-function
   #'(lambda (results)
       (when results
         (second (json:decode-json-from-string results))))
   :request-args request-args))

(defvar my-search-engines
  (list
   (make-instance 'search-engine
				  :name "My-Wiki"
				  :shortcut "w"
				  :search-url "https://en.wikipedia.org/w/index.php?search=~a"
				  :fallback-url (quri:uri "https://en.wikipedia.org/")
				  :completion-function
				  (make-wikipedia-completion)
				  )
   (make-instance 'search-engine
				  :name "My-Google"
				  :shortcut "g"
				  :search-url "https://google.com/search?q=~a"
				  :fallback-url (quri:uri "https://google.com")
				  :completion-function
				  (make-google-completion)
				  )
   )
  "List of search engines.")



(define-configuration :context-buffer
    "Go through the search engines above and make-search-engine out of them."
  ((search-engines
    (append
     ;; (mapcar (lambda (engine) (apply 'make-search-engine engine))
     my-search-engines %slot-default%))))


(defvar *my-keymap* (make-keymap "my-map")
  "Keymap for `my-mode'.")

(nyxt/mode/bookmarklets:define-bookmarklet-command-global org-capture
    "Org capture templates."
  "(function() {
     var url = location.href;
     var title = document.title;
     var body = window.getSelection().toString();
     var captureURL = 'org-protocol://capture?' + new URLSearchParams({url: url, title: title, body: body}).toString();
     alert(captureURL); // Debugging: Display the capture URL
     window.location.href = captureURL;
   })()")

;; Helper functions

(defun buffer-url ()
  "Returns the URL of the current buffer."
  (quri:render-uri (url (current-buffer))))

(defun buffer-title ()
  "Returns the title of the current buffer."
  (title (current-buffer)))

(nyxt::load-lisp "~/.config/nyxt/theme.lisp")

(nyxt::load-lisp "~/.config/nyxt/percentage.lisp")

(define-command toggle-read/unread ()
  ;; TODO: Add an arrows package and use that
  (let ((html (document-model (current-buffer))))
    (alexandria:when-let (button (find-if (lambda (n) (equal "Read / Unread" (plump:attribute n "aria-label")))
                                          (plump:get-elements-by-tag-name html "button")))
      (nyxt/dom:click-element button))))

(define-mode outlook-mode ()
  ((keyscheme-map (define-keyscheme-map "outlook-mode" ()
                    nyxt/keyscheme:vi-normal (list "C-c C-r" 'toggle-read/unread)
                    nyxt/keyscheme:vi-insert (list "C-c C-r" 'toggle-read/unread)))))

(define-auto-rule '(match-host "outlook.office.com")
    :included '(outlook-mode))

(nyxt/mode/bookmarklets:define-bookmarklet-command-global ;;; this bookmarklet adjusts youtube speed settings
    hack-youtube-speed 
    "The internet is mine for the taking!! MUAHAHAHA... change play speed of videos"
  "(function() { const rate = prompt('Set the new playback rate', 2.5);
 if (rate != null) { const video = document.getElementsByTagName('video')[0];
 video.playbackRate = parseFloat(rate); } })();
 ")


(in-package :nyxt)

;; doesn't work the right way yet
(defun downloads-handler (url)
  (cond ((str:ends-with? ".pdf" (quri:render-uri url))
         (define-configuration buffer
             ((download-path (make-instance 'download-data-path
                                            :dirname "~/Documents/pdf/dl/")))))
        (t
         (define-configuration buffer
             ((download-path (make-instance 'download-data-path
                                            :dirname "~/Downloads"))))))
  url)


(define-configuration browser
    ((before-download-hook
      (hooks:add-hook %slot-default (make-handler-download #'downloads-handler)))))

;; (define-configuration nyxt::certificates
;;     (nyxt-certificate:certificate-exception "https://100.98.92.133:9090")
;;   (nyxt-certificate:certificate-exception "https://localhost:32400"))

;; (defun change-youtube-volume (increase)
;;   "Change the volume of the currently focused YouTube video in Nyxt browser.
;;   INCREASE: If T, increase the volume, otherwise decrease."
;;   (execute-javascript
;;    (format nil
;;            "var videos = document.querySelectorAll('video[src*=\"youtube.com\"]');
;;             videos.forEach(function(video) {
;;               var currentVolume = video.volume;
;;               var newVolume = ~a ? Math.min(currentVolume + 0.1, 1) : Math.max(currentVolume - 0.1, 0);
;;               video.volume = newVolume;
;;             });"
;;            increase)))

;; (defun handle-volume-increase ()
;;   "Handle the volume increase command."
;;   (change-youtube-volume t))

;; (defun handle-volume-decrease ()
;;   "Handle the volume decrease command."
;;   (change-youtube-volume nil))

;; (define-command "volume-increase" ()
;;   "Increase volume of the focused YouTube video."
;;   (handle-volume-increase))

;; (define-command "volume-decrease" ()
;;   "Decrease volume of the focused YouTube video."
;;   (handle-volume-decrease))

;; (bind-key "C-c +" "volume-increase")
;; (bind-key "C-c -" "volume-decrease")


