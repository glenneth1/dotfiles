(define-configuration (web-buffer prompt-buffer panel-buffer
                                  nyxt/mode/editor:editor-buffer)
    ((default-modes (pushnew 'nyxt/mode/emacs:emacs-mode %slot-value%))))

(define-configuration browser
    ((theme theme:+dark-theme+)))

