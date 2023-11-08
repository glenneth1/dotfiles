;;;; gt-python-config.el --- Configuration for writing text documents  -*- lexical-binding: t; -*-

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


(provide 'gt-social-config)
;;; gt-python-config.el ends here
