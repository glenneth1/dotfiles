;;;; gt-writing-config.el --- Packages used for writing  -*- lexical-binding: t; -*-

;; Copyright (C) 2023
;; SPDX-License-Identifier: MIT

;; Author: Glenn Thompson

;;; Commentary:

;; Packages used for my own basic python programming requirements.

;;; Code:

(use-package pandoc
  :defer 3
  :after org)

(use-package ox-pandoc
  :defer 3
  :after org)

(use-package pandoc-mode
;;   :demand t
;;   :config
  pandoc-mode 1)

(use-package pdf-tools
  :demand t
  :config
  (pdf-tools-install)
  (pdf-loader-install))

(add-hook 'pdf-view-mode-hook (lambda() (linum-mode -1)))

(defun my-turn-off-line-numbers ()
  "Disable line numbering in the current buffer."
  (display-line-numbers-mode -1))
(add-hook 'pdf-view-mode-hook #'my-turn-off-line-numbers)

(setq nov-unzip-program "/usr/bin/unzip")

(use-package org-noter
  :config
  ;; Your org-noter config ........
  (require 'org-noter-pdftools))

(use-package org-pdftools
  :hook (org-mode . org-pdftools-setup-link))

(use-package org-noter-pdftools
  :after org-noter
  :config
  ;; Add a function to ensure precise note is inserted
  (defun org-noter-pdftools-insert-precise-note (&optional toggle-no-questions)
    (interactive "P")
    (org-noter--with-valid-session
     (let ((org-noter-insert-note-no-questions (if toggle-no-questions
                                                   (not org-noter-insert-note-no-questions)
                                                 org-noter-insert-note-no-questions))
           (org-pdftools-use-isearch-link t)
           (org-pdftools-use-freepointer-annot t))
       (org-noter-insert-note (org-noter--get-precise-info)))))

  ;; fix https://github.com/weirdNox/org-noter/pull/93/commits/f8349ae7575e599f375de1be6be2d0d5de4e6cbf
  (defun org-noter-set-start-location (&optional arg)
    "When opening a session with this document, go to the current location.
With a prefix ARG, remove start location."
    (interactive "P")
    (org-noter--with-valid-session
     (let ((inhibit-read-only t)
           (ast (org-noter--parse-root))
           (location (org-noter--doc-approx-location (when (called-interactively-p 'any) 'interactive))))
       (with-current-buffer (org-noter--session-notes-buffer session)
         (org-with-wide-buffer
          (goto-char (org-element-property :begin ast))
          (if arg
              (org-entry-delete nil org-noter-property-note-location)
            (org-entry-put nil org-noter-property-note-location
                           (org-noter--pretty-print-location location))))))))
  (with-eval-after-load 'pdf-annot
    (add-hook 'pdf-annot-activate-handler-functions #'org-noter-pdftools-jump-to-note)))

(setq +latex-viewers '(pdf-tools))
;; (add-hook LaTeX-mode-hook #'xenops-mode)

;; (latex +cdlatex +latexmk +lsp)

(provide 'gt-writing-config)
;;; crafted-writing-packages.el ends here
