;;;; gt-writing-packages.el --- Packages used for writing  -*- lexical-binding: t; -*-

;; Copyright (C) 2023
;; SPDX-License-Identifier: MIT

;; Author: Glenn Thompson

;;; Commentary:

;; Packages used for my own basic python programming requirements.

;;; Code:


(add-to-list 'package-selected-packages 'pandoc)
(add-to-list 'package-selected-packages 'ox-pandoc)
(add-to-list 'package-selected-packages 'pandoc-mode)
(add-to-list 'package-selected-packages 'nov)
(add-to-list 'package-selected-packages 'org-noter)
(add-to-list 'package-selected-packages 'org-noter-pdftools)
(add-to-list 'package-selected-packages 'org-pdftools)
(add-to-list 'package-selected-packages 'djvu)

(provide 'gt-writing-packages)
;;; crafted-writing-packages.el ends here
