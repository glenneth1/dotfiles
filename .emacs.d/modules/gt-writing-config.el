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

(provide 'gt-writing-config)
;;; crafted-writing-packages.el ends here
