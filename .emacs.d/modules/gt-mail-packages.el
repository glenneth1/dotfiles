;;; gt-mail-packages.el  -*- lexical-binding: t; -*-

;; Copyright (C) 2023
;; SPDX-License-Identifier: MIT

;; Author: Glenn Thompson

;; Commentary

;; Packages to mu4e configuration

;;; Code:

;; Second brain/zettlekasten by Protesilaos Stavrou (also known as
;; Prot), similar features as Org-Roam, but keeps everything in a
;; single directory, does not use a database preferring filenameing
;; conventions and grep instead.
(add-to-list 'package-selected-packages 'mu4e)

(provide 'gt-mail-packages)
;;; gt-mail-packages.el ends here
