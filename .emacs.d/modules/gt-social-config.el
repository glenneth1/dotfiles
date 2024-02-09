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

(defun gt-irc-connect ()
  "Connect to an IRC server and join a specific channel."
  (interactive)
  (erc-tls :server "irc.twitch.tv"
           :password "oauth:m6u6sjrcwz6z9wxfoo8vq8i6hnkl5u"
           :nick "glenneth1"
           :id "twitch.tv/systemcrafters")
  (sleep-for 3) ; Wait for a few seconds
  (erc-cmd-QUOTE "CAP REQ :twitch.tv/membership")
  (erc-cmd-JOIN "#systemcrafters"))

(global-set-key (kbd "C-c C-i") 'gt-irc-connect)


(erc-colorize-mode 1)

(require 'erc-services)
(erc-services-mode 1)

(eval-after-load "erc"
  '(progn

     (setq erc-prompt-for-nickserv-password "")))


;; Set autoconnect networks
(defun my-erc ()
  "Connect to my ZNC Bouncer server."

  (interactive)
  (erc-tls :server "100.98.92.133" :port 5555 :nick "glenneth" :full-name "glenneth"))

(erc-hl-nicks-mode 1)

(setq erc-hide-list '("JOIN" "PART" "QUIT"))

;; (require 'rcirc)
;; (require 'auth-source)
;; (require 'password-cache)

;; (defun my-rcirc-connect ()
;;   "Connect to IRC using rcirc with authentication and channel auto-join."
;;   (interactive)
;;   (let* ((auth-info (car (auth-source-search :max 1
;;                                               :host "100.98.92.133"
;;                                               :port "5555"
;;                                               :require '(:user :secret))))
;;          (username (plist-get auth-info :user))
;;          (password (funcall (plist-get auth-info :secret)))
;;          (irc-port "5555") ; Replace "your-irc-port" with your actual port number
;;          (server-info (list "100.98.92.133"
;;                             :port irc-port
;;                             :nick username
;;                             :user username
;;                             :password (list "100.98.92.133" 5555 username password)
;;                             :channels '("#systencrafters" "#systemcrafters-live" "#nyxt"))))
;;     (apply 'rcirc-connect server-info)))

;; (my-rcirc-connect)

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

(provide 'gt-social-config)
;;; gt-social-config.el ends here
