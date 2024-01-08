(define-configuration (web-buffer prompt-buffer panel-buffer
                       nyxt/mode/editor:editor-buffer)
  ((default-modes (pushnew 'nyxt/mode/emacs:emacs-mode %slot-value%))))

(define-configuration browser
  ((theme theme:+dark-theme+)))

(define-configuration (web-buffer)
  ((default-modes (pushnew 'nyxt/mode/style:dark-mode %slot-value%))))

(define-configuration browser
  ((theme theme:+light-theme+)))

(define-configuration browser
  ((theme theme:+light-theme+)))

(define-configuration browser
  ((theme theme:+dark-theme+)))

(define-configuration (web-buffer)
  ((default-modes
    (remove-if (lambda (nyxt::m) (string= (symbol-name nyxt::m) "DARK-MODE"))
               %slot-value%))))

(defvar *my-keymap* (make-keymap "my-map")
  "Keymap for `my-mode'.")

(define-command org-capture (&optional (buffer (current-buffer)))
  "Org-capture current page."
  (eval-in-emacs
   `(org-link-set-parameters
     "next"
     :store (lambda ()
              (org-store-link-props
               :type "next"
               :link ,(url buffer)
               :description ,(title buffer))))
   `(org-capture)))
(define-key *my-keymap* "C-M-o" 'org-capture)

