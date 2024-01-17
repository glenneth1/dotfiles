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
