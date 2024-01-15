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
           "\n * TODO %?\n  %U\n  %a\n  %i" :empty-lines 1)
      ("c" "Contact information")
      ("ca" "Acquaintances and friends" entry
       (file+headline "~/Dropbox/org/contacts.org" "Acquaintannces and friends")
      "\n * %^{Name SURNAME}\n :PROPERTIES:\n :PHONE: %^{Country Number}\n :EMAIL: %^{Email address}\n :NOTES: %?\n :END:")
      ("cf" "Family" entry
       (file+headline "~/Dropbox/org/contacts.org" "Family members")
      "\n * %^{Name SURNAME}\n :PROPERTIES:\n :PHONE: %^{Country Number}\n :EMAIL: %^{Email address}\n :NOTES: %?\n :END:")
      ("cw" "Work related" entry
       (file+headline "~/Dropbox/org/contacts.org" "Colleagues, functionaries, intermediaries")
      "\n * %^{Name SURNAME}\n :PROPERTIES:\n :PHONE: %^{Country Number}\n :LOCATION: %^{Location}\n :EMAIL: %^{Email address}\n :FUNCTION: %^{Function|Assistant|Inntermediary|External|VIP}\n :NOTES: %?\n :END:")
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
           "\n * %<%I:%M %p> - Journal :journal:\n\n%?\n\n"
           ;; ,(dw/read-file-as-string "~/Dropbox/org/Notes/Templates/Daily.org")
           :clock-in :clock-resume
           :empty-lines 1)
      ("jm" "Meeting" entry
           (file+olp+datetree "~/Dropbox/org/Journal.org")
           "\n * %<%I:%M %p> - %a :meetings:\n\n%?\n\n"
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
          "\n * TODO Follow up with %:fromname on %a\nSCHEDULED:%t\nDEADLINE: %(org-insert-time-stamp (org-read-date nil t \"+2d\"))\n\n%i\n" :immediate-finish t)
    ("er" "Read Later" entry (file+olp "~/Dropbox/org/Mail.org" "Read Later")
     "\n * TODO Read %:subject\nSCHEDULED:%t\nDEADLINE: %(org-insert-time-stamp (org-read-date nil t \"+2d\"))\n\n%a\n\n%i\n" :immediate-finish t)
("T" "TFS")
        ("Te" "Events" entry
        (file+headline "~/Dropbox/org/TFS/TFS.org" "Events")
        "* EVENT %:from\n SCHEDULED: %^t\n :PROPERTIES:\n :TOPIC: %:subject %?\n :END:")
        ("Tr" "R&R" entry
        (file+headline "~/Dropbox/org/TFS/R&R.org" "R&R")
        "* %^{Name}\n %:from\n SCHEDULED: %^t\n RETURN:%^{Return Date}t\n DESTINATION:%^{DESTINATION}\n LOCATION:%^{Current Location}\n :END:")
        ("Tm" "TEAM MOVEMENT" entry
        (file+headline "~/Dropbox/org/TFS/TFS.org" "Team Movement")
        "* MOVEMENT\n TEAM:%^{Team Number}\n FROM:%^{From location}\n TO:%^{To location}%\n SCHEDULED: %^t\n RETURN:%^{Return Date}t\n :END:")
        ;; New Templates
        ("Tu" "Project Update" entry
         (file+headline "~/Dropbox/org/TFS/TFS.org" "Updates")
         "* %^{Update Title} - %^t\n
          - **Overall Project Status:** %^{Status}\n
          - **Key Accomplishments:** %?\n
          - **Challenges and Issues:** %^{Challenges}\n
          - **Upcoming Milestones:** %^{Milestones}\n
          - **Next Steps/Action Items:** %^{Next Steps}\n")

        ("Ti" "Action Item" entry (file+olp "~/Dropbox/org/TFS/actions.org" "Action Items")
         "* TODO %^{Action Item} - %^t\n
          - **Assigned To:** %^{Assignee}\n
          - **Priority:** %^{High|Medium|Low}\n
          - **Due Date:** %^t\n
          - **Description:** %?\n
          - **Status:** TODO\n
          - **Notes:** %?\n")

        ("Ts" "Issue/Challenge" entry (file+olp "~/Dropbox/org/TFS/issues.org" "Issues")
         "* %^{Issue/Challenge Title} - %^t\n
          - **Details/Context:** %?\n
          - **Impact:** %?\n
          - **Priority:** %^{High|Medium|Low}\n
          - **Assigned To:** %^{Assignee}\n
          - **Status:** %^{Open|In Progress|Resolved}\n
          - **Next Steps/Action Items:** %?\n
          - **Notes:** %?\n")

        ("Td" "Decision" entry (file+olp "~/Dropbox/org/TFS/docs.org" "Decisions")
         "* TODO %^{Decision} - %^t\n
          - **Decision Context:** %?\n
          - **Options Considered:** %^{Options}\n
          - **Decision Rationale:** %?\n
          - **Implications and Risks:** %?\n
          - **Next Steps/Action Items:** %^{Action Items}\n
          - **Status:** TODO\n")

        ("Tc" "Client Communication" entry (file+olp "~/Dropbox/org/TFS/actions.org" "Client Communication")
         "* TODO %^{Client/Stakeholder} - %^t\n
          - **Meeting Type:** %^{Meeting Type}\n
          - **Attendees:** %?\n
          - **Agenda:** %^{Agenda}\n
          - **Discussion Points:** %?\n
          - **Meeting Outcomes/Agreements:** %?\n
          - **Action Items:** %^{Action Items}\n
          - **Follow-up Needed:** %^{Follow-up Needed|Yes|No}\n
          - **Next Meeting Date:** %^t\n
          - **Notes:** %?\n
          - **Status:** TODO\n") 

        ("Tb" "Budget/Expenses" entry (file+olp "~/Dropbox/org/TFS/budget.org" "Budget/Expenses")
         "* TODO %^{Expense/Update} - %^t\n
          - **Amount:** %^{Amount}\n
          - **Expense Category:** %^{Category}\n
          - **Justification:** %?\n
          - **Approval Status:** %^{Approval Status}\n
          - **Receipts Attached:** %^{Yes|No}\n
          - **Next Steps/Action Items:** %^{Action Items}\n
          - **Status:** TODO\n")


        ("Tx" "Documentation Task" entry (file+olp "~/Dropbox/org/TFS/docs.org" "Documentation")
         "* TODO %^{Documentation Task} - %^t\n
          - **Assigned To:** %^{Assignee}\n
          - **Priority:** %^{High|Medium|Low}\n
          - **Due Date:** %^t\n
          - **Description:** %?\n
          - **Status:** TODO\n
          - **Notes:** %?\n")

        ("Tk" "Knowledge Sharing" entry (file+olp "~/Dropbox/org/TFS/actions.org" "Knowledge Sharing")
         "* %^{Topic Title} - %^t\n
          - **Presenter/Author:** %^{Presenter/Author}\n
          - **Audience:** %^{Audience}\n
          - **Format:** %^{Presentation|Documentation|Discussion}\n
          - **Source/Context:** %^{Source/Context}\n
          - **Key Points:** %?\n
          - **Takeaways:** %?\n
          - **Resources/References:** %?\n
          - **Questions/Discussion:** %?\n
          - **Follow-up Actions:** %?\n
          - **Feedback:** %^{Positive|Constructive|None}\n")

        ("Tf" "Feedback" entry (file+olp "~/Dropbox/org/TFS/feedback.org" "Feedback")
         "* %^{Feedback Title} - %^t\n
          - **Feedback From:** %^{Sender}\n
          - **Sender's Contact:** %^{Contact Details}\n
          - **Feedback Type:** %^{Positive|Constructive|Negative}\n
          - **Project/Task/Person:** %?\n
          - **Specifics/Details:** %?\n
          - **Rating (1-5):** %^{Rating}\n
          - **Impact/Implications:** %?\n
          - **Suggestions/Actions:** %?\n
          - **Status:** %^{Open|Acknowledged|Resolved}\n
          - **Follow-up Required:** %^{Yes|No}\n
          - **Follow-up Action Items:** %?\n
          - **Notes:** %?\n")

        ("Tt" "Training" entry (file+olp "~/Dropbox/org/TFS/TFS.org" "Training")
         "* %^{Training Title} - %^t\n
          - **Trainer/Instructor:** %^{Trainer/Instructor}\n
          - **Participants:** %^{Participants}\n
          - **Location:** %^{Location}\n
          - **Duration:** %^{Duration}\n
          - **Agenda:** %?\n
          - **Key Learnings:** %?\n
          - **Exercises/Hands-on:** %?\n
          - **Materials/Resources:** %?\n
          - **Feedback:** %^{Positive|Constructive|None}\n
          - **Follow-up Actions:** %?\n")
))
;; (use-package doct
;;   :ensure t)

;; (setq org-capture-templates
;;       (doct
;;        (("t" "Tasks / Projects")
;;         ("tt" "Task" entry (file+olp "~/Dropbox/org/Tasks.org" "Inbox")
;;          "* TODO %?\n%U\n%a\n%i\n- **Priority:** %^{High|Medium|Low}\n ; Add priority\n- **Due Date:** %^t\n ; Add due date\n- **Project:** %^{Project}\n ; Add project association\n- **Tags:** %^{Tags}\n ; Add tags for categorization\n- **Assigned To:** %^{Assignee}\n" ; Add assignment
;;          :empty-lines 1)
;;         ("c" "Contact information")
;;         ("ca" "Acquaintances and friends" entry
;;          (file+headline "~/Dropbox/org/contacts.org" "Acquaintannces and friends")
;;          "\n * %^{Name SURNAME}\n :PROPERTIES:\n :PHONE: %^{Country Number}\n :EMAIL: %^{Email address}\n :NOTES: %?\n :END:")
;;         ("cf" "Family" entry
;;          (file+headline "~/Dropbox/org/contacts.org" "Family members")
;;          "\n * %^{Name SURNAME}\n :PROPERTIES:\n :PHONE: %^{Country Number}\n :EMAIL: %^{Email address}\n :NOTES: %?\n :END:")
;;         ("cw" "Work related" entry
;;          (file+headline "~/Dropbox/org/contacts.org" "Colleagues, functionaries, intermediaries")
;;          "\n * %^{Name SURNAME}\n :PROPERTIES:\n :PHONE: %^{Country Number}\n :LOCATION: %^{Location}\n :EMAIL: %^{Email address}\n :FUNCTION: %^{Function|Assistant|Inntermediary|External|VIP}\n :NOTES: %?\n :END:")
;;         ("g" "GTD item"
;;          entry
;;          (file (lambda () (org-gtd--path org-gtd-inbox-file-basename)))
;;          "* %?\n%U\n\n  %i"
;;          :kill-buffer t)
;;         ("L" "GTD item with link to where you are in emacs now"
;;          entry
;;          (file (lambda () (org-gtd--path org-gtd-inbox-file-basename)))
;;          "* %?\n%U\n\n  %i\n  %a"
;;          :kill-buffer t)
;;         ("j" "Journal Entries")
;;         ("jj" "Journal" entry
;;          (file+olp+datetree "~/Dropbox/org/Journal.org")
;;          "\n * %<%I:%M %p> - Journal :journal:\n\n%?\n\n"
;;          :clock-in :clock-resume
;;          :empty-lines 1)
;;         ("jm" "Meeting" entry
;;          (file+olp+datetree "~/Dropbox/org/Journal.org")
;;          "\n * %<%I:%M %p> - %a :meetings:\n\n%?\n\n"
;;          :clock-in :clock-resume
;;          :empty-lines 1)
;;         ("m" "Meetings")
;;         ("ma" "Appointments" entry
;;          (file+headline "~/Dropbox/org/meetings.org" "Appointments and work-related meetings")
;;          "* MEETING %:from\nSCHEDULED: %^t\n :PROPERTIES:\n :TOPIC: %:subject %?\n :END:")
;;         ("me" "Events" entry
;;          (file+headline "~/Dropbox/org/meetings.org" "Events and conferences")
;;          "* MEETING %:from\nSCHEDULED: %^t\n :PROPERTIES:\n :TOPIC: %:subject %?\n :END:")
;;         ("mr" "Rendez-Vous" entry
;;          (file+headline "~/Dropbox/org/meetings.org" "Real life meetings")
;;          "* MEETING %^{With whom}%?\n SCHEDULED: %^t")
;;         ("I" "ideas")
;;         ("Ia" "Activity" entry
;;          (file+headline "~/Dropbox/org/ideas.org" "Activities")
;;          "* IDEA ACTIVITY %:from\nSCHEDULED: %^t\n :PROPERTIES:\n :TOPIC: %:subject %?\n :END:")
;;         ("Ie" "Email" entry
;;          (file+headline "~/Dropbox/org/meetings.org" "Emails")
;;          "* IDEA EMAIL %:from\nSCHEDULED: %^t\n :PROPERTIES:\n :TOPIC: %:subject %?\n :END:")
;;         ("Im" "MOVEMENT" entry
;;          (file+headline "~/Dropbox/org/meetings.org" "Team Movement")
;;          "* MOVEMENT %^{With whom}%?\n SCHEDULED: %^t")
;;         ("w" "Default template"
;;          entry
;;          (file+headline "~/Dropbox/org/capture.org" "Notes")
;;          "* %^{Title}\n\n  Source: %u, %c\n\n  %i"
;;          :empty-lines 1)
;;         ("s" "Web site" entry (file+headline ,(concat org-directory "Captures.org") "Inbox")
;;          (file "")
;;          "\n* %a :website:\n\n%U %?\n\n%:initial")
;;         ("p" "Protocol" entry (file+headline ,(concat org-directory "Captures.org") "Captured Notes")
;;          "\n\n* %^{Title}\nSource: %u, %c\n #+BEGIN_QUOTE\n%i\n#+END_QUOTE\n\n\n%?")
;;         ("l" "Protocol Link" entry (file+headline ,(concat org-directory "Captures.org") "Captured Notes")
;;          "\n\n* %? [[%:link][%:description]] \nCaptured On: %U")
;;         ("r" "Cookbook")
;;         ("rc" "Recipes" entry
;;          (file "~/Dropbox/org/Recipes/cookbook.org")
;;          "%(org-chef-get-recipe-from-url)"
;;          :empty-lines 1)
;;         ("rm" "Manual Cookbook" entry
;;          (file "~/Dropbox/org/Recipes/cookbook.org")
;;          "* %^{Recipe title: }\n  :PROPERTIES:\n  :source-url:\n  :servings:\n  :prep-time:\n  :cook-time:\n  :ready-in:\n  :END:\n** Ingredients\n   %?\n** Directions\n\n")
;;         ("e" "Email Workflow")
;;         ("ee" "Email"
;;          entry (expand-file-name "email.org" org-directory)
;;          "* %?" :empty-lines 1)
;;         ("ef" "Follow Up" entry (file+olp "~/Dropbox/org/Mail.org" "Follow Up")
;;          "\n * TODO Follow up with %:fromname on %a\nSCHEDULED:%t\nDEADLINE: %(org-insert-time-stamp (org-read-date nil t \"+2d\"))\n\n%i\n" :immediate-finish t)
;;         ("er" "Read Later" entry (file+olp "~/Dropbox/org/Mail.org" "Read Later")
;;          "\n * TODO Read %:subject\nSCHEDULED:%t\nDEADLINE: %(org-insert-time-stamp (org-read-date nil t \"+2d\"))\n\n%a\n\n%i\n" :immediate-finish t)
;;         ("T" "TFS")
;;         ("Te" "Events" entry
;;          (file+headline "~/Dropbox/org/TFS/TFS.org" "Events")
;;          "* EVENT %:from\n SCHEDULED: %^t\n :PROPERTIES:\n :TOPIC: %:subject %?\n :END:")
;;         ("Tr" "R&R" entry
;;          (file+headline "~/Dropbox/org/TFS/R&R.org" "R&R")
;;          "* %^{Name}\n %:from\n SCHEDULED: %^t\n RETURN:%^{Return Date}t\n DESTINATION:%^{DESTINATION}\n LOCATION:%^{Current Location}\n :END:")
;;         ("Tm" "TEAM MOVEMENT" entry
;;          (file+headline "~/Dropbox/org/TFS/TFS.org" "Team Movement")
;;          "* TEAM: %^{Team Number}\n MEMBERS:%^{Members Names}\n FROM:%^{From location}\n TO:%^{To location}%\n SCHEDULED: %^t\n RETURN:%^{Return Date}t\n **Notes:** %?\n:END:\n")
;;         ;; New Templates
;;         ("Tu" "Project Update" entry
;;          (file+headline "~/Dropbox/org/TFS/TFS.org" "Updates")
;;          "* %^{Update Title} - %^t\n- **Overall Project Status:** %^{Status}\n- **Key Accomplishments:** %?\n- **Challenges and Issues:** %^{Challenges}\n- **Upcoming Milestones:** %^{Milestones}\n- **Next Steps/Action Items:** %^{Next Steps}\n")
;;         ("Ti" "Action Item" entry (file+olp "~/Dropbox/org/TFS/actions.org" "Action Items")
;;          "* TODO %^{Action Item} - %^t\n- **Assigned To:** %^{Assignee}\n- **Priority:** %^{High|Medium|Low}\n- **Due Date:** %^t\n- **Description:** %?\n- **Status:** TODO\n- **Notes:** %?\n")
;;         ("Ts" "Issue/Challenge" entry (file+olp "~/Dropbox/org/TFS/issues.org" "Issues")
;;          "* %^{Issue/Challenge Title} - %^t\n- **Details/Context:** %?\n- **Impact:** %?\n- **Priority:** %^{High|Medium|Low}\n- **Assigned To:** %^{Assignee}\n- **Status:** %^{Open|In Progress|Resolved}\n- **Next Steps/Action Items:** %?\n- **Notes:** %?\n")
;;         ("Td" "Decision" entry (file+olp "~/Dropbox/org/TFS/docs.org" "Decisions")
;;          "* TODO %^{Decision} - %^t\n- **Decision Context:** %?\n- **Options Considered:** %^{Options}\n- **Decision Rationale:** %?\n- **Implications and Risks:** %?\n- **Next Steps/Action Items:** %^{Action Items}\n- **Status:** TODO\n")
;;         ("Tc" "Client Communication" entry (file+olp "~/Dropbox/org/TFS/actions.org" "Client Communication")
;;          "* TODO %^{Client/Stakeholder} - %^t\n- **Meeting Type:** %^{Meeting Type}\n- **Attendees:** %?\n- **Agenda:** %^{Agenda}\n- **Discussion Points:** %?\n- **Meeting Outcomes/Agreements:** %?\n- **Action Items:** %^{Action Items}\n- **Follow-up Needed:** %^{Yes|No}\n- **Next Meeting Date:** %^t\n- **Notes:** %?\n- **Status:** TODO\n")
;;         ("Tb" "Budget/Expenses" entry (file+olp "~/Dropbox/org/TFS/budget.org" "Budget/Expenses")
;;          "* TODO %^{Expense/Update} - %^t\n- **Amount:** %^{Amount}\n- **Expense Category:** %^{Category}\n- **Justification:** %?\n- **Approval Status:** %^{Approval Status}\n- **Receipts Attached:** %^{Yes|No}\n- **Next Steps/Action Items:** %^{Action Items}\n- **Status:** TODO\n")
;;         ("Tx" "Documentation Task" entry (file+olp "~/Dropbox/org/TFS/docs.org" "Documentation")
;;          "* TODO %^{Documentation Task} - %^t\n- **Assigned To:** %^{Assignee}\n- **Priority:** %^{High|Medium|Low}\n- **Due Date:** %^t\n- **Description:** %?\n- **Status:** TODO\n- **Notes:** %?\n")
;;         ("Tk" "Knowledge Sharing" entry (file+olp "~/Dropbox/org/TFS/actions.org" "Knowledge Sharing")
;;          "* %^{Topic Title} - %^t\n- **Presenter/Author:** %^{Presenter/Author}\n- **Audience:** %^{Audience}\n- **Format:** %^{Presentation|Documentation|Discussion}\n- **Source/Context:** %^{Source/Context}\n- **Key Points:** %?\n- **Takeaways:** %?\n- **Resources/References:** %?\n- **Questions/Discussion:** %?\n- **Follow-up Actions:** %?\n- **Feedback:** %^{Positive|Constructive|None}\n")
;;         ("Tf" "Feedback" entry (file+olp "~/Dropbox/org/TFS/feedback.org" "Feedback")
;;          "* %^{Feedback Title} - %^t\n- **Feedback From:** %^{Sender}\n- **Sender's Contact:** %^{Contact Details}\n- **Feedback Type:** %^{Positive|Constructive|Negative}\n- **Project/Task/Person:** %?\n- **Specifics/Details:** %?\n- **Rating (1-5):** %^{Rating}\n- **Impact/Implications:** %?\n- **Suggestions/Actions:** %?\n- **Status:** %^{Open|Acknowledged|Resolved}\n- **Follow-up Required:** %^{Yes|No}\n- **Follow-up Action Items:** %?\n- **Notes:** %?\n")
;;         ("Tt" "Training" entry (file+olp "~/Dropbox/org/TFS/TFS.org" "Training")
;;          "* %^{Training Title} - %^t\n- **Trainer/Instructor:** %^{Trainer/Instructor}\n- **Participants:** %^{Participants}\n- **Location:** %^{Location}\n- **Duration:** %^{Duration}\n- **Agenda:** %?\n- **Key Learnings:** %?\n- **Exercises/Hands-on:** %?\n- **Materials/Resources:**%?\n- **Feedback:** %^{Positive|Constructive|None}\n- **Follow-up Actions:** %?\n")
;; )))

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
;;  (require 'rainbow-delimiters)
  (rainbow-delimiters-mode 1))
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

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


;; (defun set-global-line-spacing (value)
;;   "Set the line spacing globally in all buffers."
;;   (interactive "nEnter line spacing value: ")
;;   (setq-default line-spacing value)
;;   (redraw-display)) ; Redraw the display to reflect the changes

;; (global-set-key (kbd "C-c s") 'set-global-line-spacing) ; Bind the function to a key (optional)
