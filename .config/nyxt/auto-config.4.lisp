(define-configuration (web-buffer prompt-buffer panel-buffer
                                  nyxt/mode/editor:editor-buffer)
    ((default-modes (pushnew 'nyxt/mode/emacs:emacs-mode %slot-value%))))

(define-configuration browser
    ((theme theme:+dark-theme+)))

(define-configuration (web-buffer)
    ((default-modes (pushnew 'nyxt/mode/style:dark-mode %slot-value%))))

(define-configuration (web-buffer)
    ((default-modes (pushnew 'nyxt/mode/style:dark-mode %slot-value%))))

(define-configuration (web-buffer)
    ((default-modes
         (remove-if (lambda (nyxt::m) (string= (symbol-name nyxt::m) "DARK-MODE"))
                    %slot-value%))))

;; (define-hook! user:deny-device-access ((request browse:web-request))
;;   "Deny device access requests."
;;   (when (and (equalp (web-request-url request) "https://www.youtube.com/")
;;              (web-request-has-permission? request :devices))
;;     (web-request-deny request :devices)))

(define-command "deny-youtube-device-access"
    ()
  "Deny device access requests for YouTube."
  (web-mode-execute-script (current-window)
                           "(navigator.mediaDevices.getUserMedia = () => Promise.reject(new Error('Permission denied'));"))

(push! '("https://www.youtube.com/*" deny-youtube-device-access) browse:browser-rules)
