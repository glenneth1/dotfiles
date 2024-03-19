;;; gt-mail-config.el  -*- lexical-binding: t; -*-

;; Copyright (C) 2023
;; SPDX-License-Identifier: MIT

;; Author: Glenn Thompson

;; Commentary

;; Provides basic configuration for Org Mode.

;;; Code:

(add-to-list 'load-path "/usr/share/emacs/site-lisp/mu4e/")
(require 'mu4e)
:ensure nil
:config

;; This is set to 't' to avoid mail syncing issues when using mbsync
(setq mu4e-change-filenames-when-moving t)

;; Refresh mail using isync every 60 minutes
(setq mu4e-update-interval (* 60 60))
(setq mu4e-get-mail-command "mbsync -a")
(setq mu4e-maildir "~/Mail")

;; Make sure plain text mails flow correctly for recipients
(setq mu4e-compose-format-flowed t)

;; Configure the function to use for sending mail
(setq message-send-mail-function 'smtpmail-send-it)

(setq mu4e-contexts
      (list
       ;; Work account
       (make-mu4e-context
        :name "Gmail"
        :match-func
        (lambda (msg)
          (when msg
            (string-prefix-p "/Gmail" (mu4e-message-field msg :maildir))))
        :vars '((user-mail-address . "glennt40@gmail.com")
                (user-full-name    . "Glenn Thompson")
                (smtpmail-smtp-server  . "smtp.gmail.com")
                (smtpmail-smtp-service . 465)
                (smtpmail-stream-type  . ssl)
                (mu4e-compose-signature . "Glenn via Gmail")
                (mu4e-drafts-folder  . "/Gmail/[Google Mail]/Drafts")
                (mu4e-sent-folder  . "/Gmail/[Google Mail]/Sent Mail")
                (mu4e-refile-folder  . "/Gmail/[Google Mail]/All Mail")
                (mu4e-trash-folder  . "/Gmail/[Google Mail]/Bin")))

       ;; Personal account
       (make-mu4e-context
        :name "Kirstol"
        :match-func
        (lambda (msg)
          (when msg
            (string-prefix-p "/Kirstol" (mu4e-message-field msg :maildir))))
        :vars '((user-mail-address . "glenn@kirstol.org")
                (user-full-name    . "Glenn Kirstol")
                (smtpmail-smtp-server  . "eu05.server.plus")
                (smtpmail-smtp-service . 465)
                (smtpmail-stream-type  . ssl)
                (mu4e-compose-signature . "Glenn via Kirstol")
                (mu4e-drafts-folder  . "/Kirstol/Drafts")
                (mu4e-sent-folder  . "/Kirstol/Sent")
                (mu4e-refile-folder  . "/Kirstol/Archive")
                (mu4e-trash-folder  . "/Kirstol/Trash")))

       ;; Personal account
       (make-mu4e-context
        :name "Purpl"
        :match-func
        (lambda (msg)
          (when msg
            (string-prefix-p "/Kirstol" (mu4e-message-field msg :maildir))))
        :vars '((user-mail-address . "glenn@purplasylum.net")
                (user-full-name    . "Glenn Purpl")
                (smtpmail-smtp-server  . "mail.privateemail.com")
                (smtpmail-smtp-service . 465)
                (smtpmail-stream-type  . ssl)
                (mu4e-compose-signature . "Glenn via PurplAsylum")
                (mu4e-drafts-folder  . "/Purpl/Drafts")
                (mu4e-sent-folder  . "/Purpl/Sent")
                (mu4e-refile-folder  . "/Purpl/Archive")
                (mu4e-trash-folder  . "/Purpl/Trash")))

       ;; Work mirror account
       (make-mu4e-context
        :name "Versar"
        :match-func
        (lambda (msg)
          (when msg
            (string-prefix-p "/Versar" (mu4e-message-field msg :maildir))))
        :vars '((user-mail-address . "versar@kirstol.org")
                (user-full-name    . "Glenn Versar")
                (smtpmail-smtp-server  . "eu05.server.plus")
                (smtpmail-smtp-service . 465)
                (smtpmail-stream-type  . ssl)
                (mu4e-compose-signature . "Glenn via Versar Mirror")
                (mu4e-drafts-folder  . "/Versar/Drafts")
                (mu4e-sent-folder  . "/Versar/Sent")
                (mu4e-refile-folder  . "/Versar/Archive")
                (mu4e-trash-folder  . "/Versar/Trash")))))

(setq mu4e-maildir-shortcuts
      '(("/Gmail/Inbox"             . ?i)
        ("/Gmail/[Google Mail]/Sent Mail" . ?s)
        ("/Gmail/[Google Mail]/Bin"     . ?t)
        ("/Gmail/[Google Mail]/Drafts"    . ?d)
        ("/Gmail/[Google Mail]/All Mail"  . ?a)))

(require 'mu4e-org)

;; Do not reply to yourself:
(setq mu4e-compose-reply-ignore-address '("no-?reply" "glennt40@gmail.com"))

;; Configure desktop notifs for incoming emails:
(use-package mu4e-alert
  :ensure t
  :init
  (defun perso--mu4e-notif ()
    "Display both mode line and desktop alerts for incoming new emails."
    (interactive)
    (mu4e-update-mail-and-index 1)        ; getting new emails is ran in the background
    (mu4e-alert-enable-mode-line-display) ; display new emails in mode-line
    (mu4e-alert-enable-notifications))    ; enable desktop notifications for new emails
  (defun perso--mu4e-refresh ()
    "Refresh emails every 300 seconds and display desktop alerts."
    (interactive)
    (mu4e t)                            ; start silently mu4e (mandatory for mu>=1.3.8)
    (run-with-timer 0 300 'perso--mu4e-notif))
  :after mu4e
  :bind ("<f2>" . perso--mu4e-refresh)  ; F2 turns Emacs into a mail client
  :config
  ;; Mode line alerts:
  (add-hook 'after-init-hook #'mu4e-alert-enable-mode-line-display)
  ;; Desktop alerts:
  (mu4e-alert-set-default-style 'libnotify)
  (add-hook 'after-init-hook #'mu4e-alert-enable-notifications)
  ;; Only notify for "interesting" (non-trashed) new emails:
  (setq mu4e-alert-interesting-mail-query
        (concat
         "flag:unread maildir:/Inbox"
         " AND NOT flag:trashed")))

(use-package org-mime
  :demand t
  :config
  (setq org-mime-export-options '(:section-numbers nil
                                                   :with-author nil
                                                   :with-toc nil)))

(add-hook 'org-mime-html-hook
          (lambda ()
            (org-mime-change-element-style
             "pre" (format "color: %s; background-color: %s; padding: 0.5em;"
                           "#E6E1DC" "#232323"))))

(add-hook 'message-send-hook 'org-mime-confirm-when-no-multipart)


(setq gnus-secondary-select-methods
      '(
        (nnimap "localhost"
                (nnimap-address "localhost")
                (nnimap-server-port 1143)
                (nnimap-stream network))))

(setq gnus-posting-styles
      '((".*" ; Matches all groups of messages
         (address "Glenn Thompson <GThompson@versar.com>")
         (From "Glenn Thompson <GThompson@versar.com>")
         ("X-Message-SMTP-Method" "smtp localhost 1025 GThompson@versar.com"))))


(add-hook 'mu4e-view-mode-hook
          'gt-mu4e-view-mode-hook)
(defun gt-mu4e-view-mode-hook ()
  "Custom 'mu4e-view-mode' behaviours.
Used in 'mu4e-view-mode-hook'."
  (setq-local shr-use-colors nil))

;; (add-to-list 'load-path "~/.emacs.d/src/consult-mu/")
;; (add-to-list 'load-path "~/.emacs.d/src/consult-mu/extras/")
;; (use-package consult-mu
;;   :after (consult mu4e)
;;   :custom
;;   ;;maximum number of results shown in minibuffer
;;   (consult-mu-maxnum 200)
;;   ;;show preview when pressing any keys
;;   (consult-mu-preview-key 'any)
;;   ;;do not mark email as read when previewed
;;   (consult-mu-mark-previewed-as-read nil)
;;   ;;do not amrk email as read when selected. This is a good starting point to ensure you would not miss important emails marked as read by mistake especially when trying this package out. Later you can change this to t.
;;   (consult-mu-mark-viewed-as-read nil)
;;   ;; open the message in mu4e-view-buffer when selected.
;;   (consult-mu-action #'consult-mu--view-action)
;;   )


(provide 'gt-mail-config)

;;; gt-mail-config.el ends here
