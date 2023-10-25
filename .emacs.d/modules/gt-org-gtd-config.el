;;; gt-superagenda-config.el  -*- lexical-binding: t; -*-

;; Copyright (C) 2023
;; SPDX-License-Identifier: MIT

;; Author: Glenn Thompson

;; Commentary

;; Provides basic configuration for Org Super Agenda.

;;; Code:

(setq org-gtd-update-ack "3.0.0")

(use-package swiper)
(global-set-key (kbd"C-s") 'swiper)
;; (global-set-key (kbd"C-c C-c") 'org-gtd-organize)

 ;; set up 'SPC' as the global leader key
 ;;  (general-create-definer dt/leader-keys
 ;;    :states '(normal insert visual emacs)
 ;;    :keymaps 'override
 ;;    :prefix "SPC" ;; set leader
 ;;    :global-prefix "M-SPC") ;; access leader in insert mode

;; (setq org-gtd-directory "~/Dropbox/org/org-gtd")

(use-package org-gtd
  :after org
;;   :quelpa (org-gtd :fetcher github :repo "trevoke/org-gtd.el"
;;                    :commit "3.0.0" :upgrade t)
  :demand t
  :custom
  (setq org-directory "~/Dropbox/org/")
  (setq org-gtd-directory "~/Dropbox/org/org-gtd/")
  (org-edna-use-inheritance t)
  (org-gtd-organize-hooks '(org-gtd-set-area-of-focus org-set-tags-command))
  :config
  (org-edna-mode)
  :bind
  (("C-c d c" . org-gtd-capture)
   ("C-c d e" . org-gtd-engage)
   ("C-c d p" . org-gtd-process-inbox)
   :map org-gtd-clarify-map
   ("C-c c" . org-gtd-organize)))

(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd"C-c o c") 'org-capture)
(setq org-capture-templates
    `(("t" "Tasks / Projects")
      ("tt" "Task" entry (file+olp "~/Dropbox/org/Tasks.org" "Inbox")
           "* TODO %?\n  %U\n  %a\n  %i" :empty-lines 1)
      ("c" "Contact information")
      ("ca" "Acquaintances and friends" entry
       (file+headline "~/Dropbox/org/contacts.org" "Acquaintannces and friends")
      "* %^{Name SURNAME}\n :PROPERTIES:\n :PHONE: %^{Country Number}\n :EMAIL: %^{Email address}\n :NOTES: %?\n :END:")
      ("cf" "Family" entry
       (file+headline "~/Dropbox/org/contacts.org" "Family members")
      "* %^{Name SURNAME}\n :PROPERTIES:\n :PHONE: %^{Country Number}\n :EMAIL: %^{Email address}\n :NOTES: %?\n :END:")
      ("cw" "Work related" entry
       (file+headline "~/Dropbox/org/contacts.org" "Colleagues, functionaries, intermediaries")
      "* %^{Name SURNAME}\n :PROPERTIES:\n :PHONE: %^{Country Number}\n :EMAIL: %^{Email address}\n:FUNCTION: %^{Function|Assistant|Inntermediary|External|VIP}\n :NOTES: %?\n :END:")
        ("g" "GTD item"
                 entry
                 (file (lambda () (org-gtd--path org-gtd-inbox-file-basename)))
                 "* %?\n%U\n\n  %i"
                 :kill-buffer t)
        ("L" "GTD item with link to where you are in emacs now"
                 entry
                 (file (lambda () (org-gtd--path org-gtd-inbox-file-basename)))
                 "* %?\n%U\n\n  %i\n  %a"
                 :kill-buffer t)
        ("j" "Journal Entries")
        ("jj" "Journal" entry
           (file+olp+datetree "~/Dropbox/org/Journal.org")
           "\n* %<%I:%M %p> - Journal :journal:\n\n%?\n\n"
           ;; ,(dw/read-file-as-string "~/Dropbox/org/Notes/Templates/Daily.org")
           :clock-in :clock-resume
           :empty-lines 1)
      ("jm" "Meeting" entry
           (file+olp+datetree "~/Dropbox/org/Journal.org")
           "* %<%I:%M %p> - %a :meetings:\n\n%?\n\n"
           :clock-in :clock-resume
           :empty-lines 1)
    ("m" "Meetings")
        ("ma" "Appointments" entry
        (file+headline "~/Dropbox/org/meetings.org" "Appointments and work related meetings")
        "* MEETING %:from\nSCHEDULED: %^t\n :PROPERTIES:\n :TOPIC: %:subject %?\n :END:")
        ("me" "Events" entry
        (file+headline "~/Dropbox/org/meetings.org" "Events and conferences")
        "* MEETING %:from\nSCHEDULED: %^t\n :PROPERTIES:\n :TOPIC: %:subject %?\n :END:")
        ("mr" "Rendez-Vous" entry
        (file+headline "~/Dropbox/org/meetings.org" "Real life meetings")
        "* MEETING %^{With whom}%?\n SCHEDULED: %^t")
 ("I" "ideas")
        ("Ia" "Activity" entry
        (file+headline "~/Dropbox/org/ideas.org" "Acitvities")
        "* IDEA ACTIVITY %:from\nSCHEDULED: %^t\n :PROPERTIES:\n :TOPIC: %:subject %?\n :END:")
        ("Ie" "Email" entry
        (file+headline "~/Dropbox/org/meetings.org" "Emails")
        "* IDEA EMAIL %:from\nSCHEDULED: %^t\n :PROPERTIES:\n :TOPIC: %:subject %?\n :END:")
        ("Im" "MOVEMENT" entry
        (file+headline "~/Dropbox/org/meetings.org" "Team Movement")
        "* MOVEMENT %^{With whom}%?\n SCHEDULED: %^t")
("w" "Default template"
         entry
         (file+headline "~/Dropbox/org/capture.org" "Notes")
         "* %^{Title}\n\n  Source: %u, %c\n\n  %i"
         :empty-lines 1)
("s" "Web site" entry (file+headline ,(concat org-directory "Captures.org") "Inbox")
  (file "")
  "\n* %a :website:\n\n%U %?\n\n%:initial")
("p" "Protocol" entry (file+headline ,(concat org-directory "Captures.org") "Captured Notes")
        "\n\n* %^{Title}\nSource: %u, %c\n #+BEGIN_QUOTE\n%i\n#+END_QUOTE\n\n\n%?")
("l" "Protocol Link" entry (file+headline ,(concat org-directory "Captures.org") "Captured Notes")
        "\n\n* %? [[%:link][%:description]] \nCaptured On: %U")
("r" "Cookbook")
         ("rc" "Recipes" entry
    (file "~/Dropbox/org/Recipes/cookbook.org")
         "%(org-chef-get-recipe-from-url)"
         :empty-lines 1)
        ("rm" "Manual Cookbook" entry
   (file "~/Dropbox/org/Recipes/cookbook.org")
         "* %^{Recipe title: }\n  :PROPERTIES:\n  :source-url:\n  :servings:\n  :prep-time:\n  :cook-time:\n  :ready-in:\n  :END:\n** Ingredients\n   %?\n** Directions\n\n")
  ("e" "Email Workflow")
    ("ef" "Follow Up" entry (file+olp "~/Dropbox/org/Mail.org" "Follow Up")
          "* TODO Follow up with %:fromname on %a\nSCHEDULED:%t\nDEADLINE: %(org-insert-time-stamp (org-read-date nil t \"+2d\"))\n\n%i\n" :immediate-finish t)
    ("er" "Read Later" entry (file+olp "~/Dropbox/org/Mail.org" "Read Later")
          "* TODO Read %:subject\nSCHEDULED:%t\nDEADLINE: %(org-insert-time-stamp (org-read-date nil t \"+2d\"))\n\n%a\n\n%i\n" :immediate-finish t)
))

(defun efs/capture-mail-follow-up (msg)
  (interactive)
  (call-interactively 'org-store-link)
  (org-capture nil "ef"))

(defun efs/capture-mail-read-later (msg)
  (interactive)
  (call-interactively 'org-store-link)
  (org-capture nil "er"))

;; Add custom actions for our capture templates
(add-to-list 'mu4e-headers-actions
  '("follow up" . efs/capture-mail-follow-up) t)
(add-to-list 'mu4e-view-actions
  '("follow up" . efs/capture-mail-follow-up) t)
(add-to-list 'mu4e-headers-actions
  '("read later" . efs/capture-mail-read-later) t)
(add-to-list 'mu4e-view-actions
  '("read later" . efs/capture-mail-read-later) t)


(use-package org-fancy-priorities
  :ensure t
  :hook
  (org-mode . org-fancy-priorities-mode)
  :diminish
  :config
  (setq org-fancy-priorities-list '("⚡" "⬆" "⬇" "☕")))

(setq org-todo-keywords
      '(( sequence "TODO(t)" "NEXT(n)" "|" ":DONE(d!)")
        ( sequence "BACKLOG(b)" "PLAN(p)" "READY(r)" "ACTIVE(a)" "REVIEW(v)" "WAIT(w@/!)" "HOLD(h)" "|" "COMPLETED(c)" "CANC(k@)")))

(use-package toc-org
    :commands toc-org-enable
    :init (add-hook 'org-mode-hook 'toc-org-enable))

(add-hook 'org-mode-hook 'org-indent-mode)
(use-package org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(use-package org-superstar
  :after org
  :hook (org-mode . org-superstar-mode)
  :config
  (setq org-superstar-special-todo-items t)
            (org-superstar-mode 1)
 (setq org-superstar-headline-bullets-list '("⁖" "◉" "○" "✸" "✿")
        org-superstar-itembullet-alist '((?+ . ??) (?- . ??)))) ; changes +/- symbols in item lists

(require 'org-habit)
(add-to-list 'org-modules 'org-habit)
(setq org-habit-graph-column 60)
(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))

(use-package rainbow-delimiters
  :ensure t
  :config
  (require 'rainbow-delimiters)
  (rainbow-delimiters-mode 1))

;; (with-eval-after-load 'org (global-org-modern-mode))

(with-eval-after-load 'ox-latex
(add-to-list 'org-latex-classes
             '("org-plain-latex"
               "\\documentclass{article}
           [NO-DEFAULT-PACKAGES]
           [PACKAGES]
           [EXTRA]"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))

(provide 'gt-org-gtd-config)
;;; gt-org-gtd-config.el ends here
