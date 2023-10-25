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

(provide 'gt-social-config)
;;; gt-python-config.el ends here
