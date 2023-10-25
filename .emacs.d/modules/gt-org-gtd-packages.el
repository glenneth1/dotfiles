;;; gt-org-gtd-packages.el  -*- lexical-binding: t; -*-

;; Copyright (C) 2023
;; SPDX-License-Identifier: MIT

;; Author: Glenn Thompson

;; Commentary

;; Packages to augment Org GTD configuration

;;; Code:

;; Second brain/zettlekasten by Protesilaos Stavrou (also known as
;; Prot), similar features as Org-Roam, but keeps everything in a
;; single directory, does not use a database preferring filenameing
;; conventions and grep instead.

(add-to-list 'package-selected-packages 'org-gtd)
(add-to-list 'package-selected-packages 'swiper)
(add-to-list 'package-selected-packages 'org-fancy-priorities)
(add-to-list 'package-selected-packages 'toc-org)
(add-to-list 'package-selected-packages 'org-bullets)
(add-to-list 'package-selected-packages 'org-superstar)
(add-to-list 'package-selected-packages 'rainbow-delimiters)
;; (add-to-list 'package-selected-packages 'org-modern)

(provide 'gt-org-gtd-packages)
;;; gt-org-gtd-packages.el ends here
