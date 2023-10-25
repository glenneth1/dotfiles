;;;; gt-python-packages.el --- Packages used for writing  -*- lexical-binding: t; -*-

;; Copyright (C) 2023
;; SPDX-License-Identifier: MIT

;; Author: Glenn Thompson

;;; Commentary:

;; Packages used for my own basic python programming requirements.

;;; Code:


(add-to-list 'package-selected-packages 'python)
(add-to-list 'package-selected-packages 'company)
(add-to-list 'package-selected-packages 'eglot)
(add-to-list 'package-selected-packages 'highlight-indent-guides)

(provide 'gt-python-packages)
;;; crafted-writing-packages.el ends here
