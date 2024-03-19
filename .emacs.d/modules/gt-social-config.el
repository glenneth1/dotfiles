;;;; gt-social-config.el --- Configuration for writing text documents  -*- lexical-binding: t; -*-

;; Copyright (C) 2023
;; SPDX-License-Identifier: MIT

;; Author: Glenn Thompson

;;; Commentary:

;; Configuration for social media and chat

;;; Code:

(use-package ement
  :ensure t
  :custom
  (ement-room-prism 'both)
  (ement-save-sessions t) ;; Beware, this stores your token to disk in plain text!
  )

(erc-colorize-mode 1)

(require 'erc-services)
(erc-services-mode 1)

(eval-after-load "erc"
  '(progn

     (setq erc-prompt-for-nickserv-password "")))

(erc-hl-nicks-mode 1)

(setq erc-hide-list '("JOIN" "PART" "QUIT"))

(require 'rcirc)
(require 'auth-source)
(require 'password-cache)


;; set browser to emacs browser
;; (setq browse-url-browser-function 'eww-browse-url)

;; ;; Auto-rename new eww buffers
;; (defun gt-rename-eww-hook ()
;;   "Rename eww browser's buffer so sites open in new page."
;;   (rename-buffer "eww" t))
;; (add-hook 'eww-mode-hook #'gt-rename-eww-hook)

;; (use-package seriestracker
;;   :demand                                                   ;;To force loading seriestracker
;;   :config                                                   ;;These are the default
;;   (setq seriestracker-file (concat user-emacs-directory "seriestracker.el"
;;         seriestracker--fold-cycle 'seriestracker-all-folded ;; can also be 'seriestracker-all-unfolded or 'seriestracker-series-folded. Will deternine the folding at startup
;;         seriestracker-show-watched "hide"                   ;; whether to hide or "show" the watched episodes
;;         seriestracker-sorting-type "next")))                 ;; or "alpha" for alphabetic sort

(defun erc-sr-ht ()
  (interactive)
  (require 'erc)
  (require 'erc-sasl)
  (let ((erc-sasl-auth-source-function #'erc-auth-source-search))
    (erc-tls :server "chat.sr.ht" :port 6697 :user "glenneth/irc.libera.chat" :nick "glenneth")))

(setq auth-sources '("~/.authinfo.gpg"))

(defun my-fetch-password (&rest params)
  (require 'auth-source)
  (let ((match (car (apply 'auth-source-search params))))
    (if match
        (let ((secret (plist-get match :secret)))
          (if (functionp secret)
              (funcall secret)
            secret))
      (error "Password not found for %S" params))))

(defun my-nickserv-password (server)
  (my-fetch-password :user "glenneth/irc.libera.chat" :machine "chat.sr.ht"))

(setq circe-network-options
      '(("chat.sr.ht"
         :port 6697
         :nick "glenneth"
         :nickserv-password my-nickserv-password)))

(provide 'gt-social-config)
;;; gt-social-config.el ends here
