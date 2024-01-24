;;; gt-ui-config.el -*- lexical-binding: t; -*-

;; Copyright (C) 2023
;; SPDX-License-Identifier: MIT

;; Author: Glenn Thompson

;;; Commentary:

;; User interface customizations. Examples are icons, line numbers,
;; and how help buffers are displayed.

;; This package provides a basic, customized appearance for
;; Emacs. Specifically, it uses: Helpful to customize the information
;; and visual display of help buffers, such as that created by M-x
;; `describe-function'; All-the-icons, to provide font-based icons
;; (rather than raster or vector images); and includes some Emacs Lisp
;; demonstrations.

;;  Run `all-the-icons-install-fonts' to ensure the fonts necessary
;; for ALL THE ICONS are available on your system. You must run this
;; function if the "stop" icon at the beginning of this paragraph is
;; not displayed properly (it appears as a box with some numbers
;; and/or letters inside it).

;; Read the documentation for `all-the-icons'; on Windows,
;; `all-the-icons-install-fonts' only downloads fonts, they must be
;; installed manually. This is necessary if icons are not displaying
;; properly.

;;; Code:

;; (use-package bufler
;;   :config
;;   (bufler-workspace-mode))

;; (bufler-defgroups
;;   (group
;;    ;; Subgroup collecting all named workspaces.
;;    (auto-workspace))
;;   (group
;;    ;; Subgroup collecting all `help-mode' and `info-mode' buffers.
;;    (group-or "*Help/Info*"
;;              (mode-match "*Help*" (rx bos "help-"))
;;              (mode-match "*Info*" (rx bos "info-"))))
;;   (group
;;    ;; Subgroup collecting all special buffers (i.e. ones that are not
;;    ;; file-backed), except `magit-status-mode' buffers (which are allowed to fall
;;    ;; through to other groups, so they end up grouped with their project buffers).
;;    (group-and "*Special*"
;;               (lambda (buffer)
;;                 (unless (or (funcall (mode-match "Magit" (rx bos "magit-status"))
;;                                      buffer)
;;                             (funcall (mode-match "Dired" (rx bos "dired"))
;;                                      buffer)
;;                             (funcall (auto-file) buffer))
;;                   "*Special*")))

;;    (group
;;     ;; Subgroup collecting these "special special" buffers
;;     ;; separately for convenience.
;;     (name-match "**Special**"
;;                 (rx bos "*" (or "Messages" "Warnings" "scratch" "Backtrace") "*")))
;;    (group 
;;     ;; Group collecting all other Ement buffers
;;     (mode-match "*Ement*" (rx bos "ement-")))
;;    (group
;;     ;; Subgroup collecting all other Magit buffers, grouped by directory.
;;     (mode-match "*Magit* (non-status)" (rx bos (or "magit" "forge") "-"))
;;     (auto-directory))
;;    ;; Subgroup for Helm buffers.
;;    (mode-match "*Helm*" (rx bos "helm-"))
;;    ;; Remaining special buffers are grouped automatically by mode.
;;    (auto-mode))
;;   ;; All buffers under "~/.emacs.d" (or wherever it is).
;;   (dir user-emacs-directory)
;;   (group
;;    ;; Subgroup collecting buffers in `org-directory' (or "~/org" if
;;    ;; `org-directory' is not yet defined).
;;    (dir (if (bound-and-true-p org-directory)
;;             org-directory
;;           "~/Dropbox/org"))
;;    (group
;;     ;; Subgroup collecting indirect Org buffers, grouping them by file.
;;     ;; This is very useful when used with `org-tree-to-indirect-buffer'.
;;     (auto-indirect)
;;     (auto-file))
;;    ;; Group remaining buffers by whether they're file backed, then by mode.
;;    (group-not "*special*" (auto-file))
;;    (auto-mode))
;;   (group
;;    ;; Subgroup collecting buffers in a projectile project.
;;    (auto-projectile))
;;   (group
;;    ;; Subgroup collecting buffers in a version-control project,
;;    ;; grouping them by directory.
;;    (auto-project))
;;   ;; Group remaining buffers by directory, then major mode.
;;   (auto-directory)
;;   (auto-mode))

;;   (defun ap/tab-bar-tab-name-function ()
;;     "Return project name or tab bar name."
;;     (cl-labels ((buffer-project (buffer)
;;                   (if-let ((file-name (buffer-file-name buffer)))
;;                       (bufler-project-current nil (file-name-directory file-name))
;;                     (bufler-project-current nil (buffer-local-value 'default-directory buffer))))
;;                 (window-prev-buffers-last-project (windows)
;;                   (cl-loop for (buffer _ _) in windows
;;                            when (buffer-project buffer)
;;                            return it)))
;;       (if-let ((project (or (buffer-project (window-buffer (minibuffer-selected-window)))
;;                             (window-prev-buffers-last-project (window-prev-buffers (minibuffer-selected-window))))))
;;           (project-name project)
;;         (tab-bar-tab-name-current-with-count))))
;;   (setopt tab-bar-tab-name-function #'ap/tab-bar-tab-name-function)

;; (use-package burly
;;   :ensure t)

;; ;; Thanks alphapapa!
;; (cl-defun ap/display-buffer-in-side-window (&optional (buffer (current-buffer))
;;                                                       &key (side 'right) (slot 0))
;;   "Display BUFFER in dedicated side window.
;; With universal prefix, use left SIDE instead of right.  With two
;; universal prefixes, prompt for side and slot (which allows
;; setting up an IDE-like layout)."
;;   (interactive (list (current-buffer)
;;                      :side (pcase current-prefix-arg
;;                              ('nil 'right)
;;                              ('(0) left)
;;                              (_ (intern (completing-read "Side: " '(left right top bottom) nil t))))
;;                      :slot (pcase current-prefix-arg
;;                              ('nil 0)
;;                              ('(0) 0)
;;                              (_ (read-number "Slot: ")))))
;;   (let ((display-buffer-mark-dedicated t))
;;     (display-buffer buffer
;;                     `(display-buffer-in-side-window
;;                       (side . ,side)
;;                       (slot . ,slot)
;;                       (window-parameters
;;                        (no-delete-other-windows . t))))))

(setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
      doom-themes-enable-italic t); if nil, italics is universally disabled
(load-theme 'doom-one)

(setq user-full-name "Glenn Thompson"
      user-mail-address "Glenn@kirstol.org")

(setq org-directory "~/Dropbox/org/")

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(tab-bar-mode 1)

(server-start)

 (defun d/eshell-toggle ()
    "Minimal hack to toggle eshell."
    (interactive)
    (cond
     ((derived-mode-p 'eshell-mode) (if (one-window-p) (switch-to-prev-buffer) (delete-window)))
     ((one-window-p) (progn (select-window (split-window-below)) (shrink-window 7) (eshell)))
     (t (progn (other-window 1)
		       (if (derived-mode-p 'eshell-mode) (delete-window)
		         (progn (other-window -1) (select-window (split-window-below)) (shrink-window 7) (eshell)))))))

(defun disable-mode-line ()
(setq mode-line-format nil))

(use-package vterm
:hook (vterm-mode . disable-line-numbers)
:hook (vterm-mode . disable-mode-line)
:config
(setq shell-file-name "/bin/zsh"
vterm-max-scrollback 5000))

(set-face-attribute 'default nil
                    :font "JetBrains Mono"
                    :height 110
                    :weight 'medium)
(set-face-attribute 'variable-pitch nil
                    :font "Ubuntu"
                    :height 120
                    :weight 'medium)
(set-face-attribute 'fixed-pitch nil
                    :font "JetBrains Mono"
                    :height 110
                    :weight 'medium)
;; Makes commented text and keywords italics.
;; This is working in emacsclient but not emacs.
;; Your font must have an italic face available.
(set-face-attribute 'font-lock-comment-face nil
                    :slant 'italic)
(set-face-attribute 'font-lock-keyword-face nil
                    :slant 'italic)

;; This sets the default font on all graphical frames created after restarting Emacs.
;; Does the same thing as 'set-face-attribute default' above, but emacsclient fonts
;; are not right unless I also add this method of setting the default font.
(add-to-list 'default-frame-alist '(font . "JetBrains Mono-11"))

;; Uncomment the following line if line spacing needs adjusting.
(setq-default line-spacing 0.12)

(keymap-global-set "C-=" 'text-scale-increase)
(keymap-global-set "C--" 'text-scale-decrease)
;; (keymap-global-set "<C-wheel-up>" 'text-scale-increase)
;; (keymap-global-set "<C-wheel-down>" 'text-scale-decrease)
(keymap-global-set "C-c o r" 'recentf)
;; (keymap-global-set "C-c k b")'kill-current-buffer)
(keymap-global-set "C-c o a" 'org-agenda)
(keymap-global-set "C-c o t" 'load-theme)
(keymap-global-set "C-c o v" 'vterm)
(keymap-global-set "C-c t n" 'tab-bar-switch-to-next-tab)
(keymap-global-set "C-c t p" 'tab-bar-switch-to-prev-tab)
(keymap-global-set "C-c s t" 'org-clock-in)
(keymap-global-set "C-c s T" 'org-clock-out)
(keymap-global-set "C-c e c" 'ement-connect)
(keymap-global-set "C-c e d" 'ement-disconnect)
(keymap-global-set "C-c e t" 'd/eshell-toggle)
(keymap-global-set "C-x x c" 'ix)
(keymap-global-set "C-x x d" 'ix-delete)
(keymap-global-set "C-c b s" 'bufler-sidebar)
(keymap-global-set "C-c b b" 'bufler-switch-buffer)
(keymap-global-set "C-c o m" 'mu4e)
(keymap-global-set "C-c e u" 'elfeed-update)
(keymap-global-set "C-c e e" 'elfeed)
(keymap-global-set "C-c e a" 'elfeed-add-feed)
(keymap-global-set "C-c d n" 'denote-subdirectory)
(keymap-global-set "C-c ." 'emojify-insert-emoji)
(keymap-global-set "M-u" 'fix-word-upcase)
(keymap-global-set "M-l" 'fix-word-downcase)
(keymap-global-set "M-c" 'fix-word-capitalize)
(keymap-global-set "C-c o f" '0x0-upload-file)
(keymap-global-set "C-c o t" '0x0-upload-text)
(keymap-global-set "C-c r c" 'my-erc)
(keymap-global-unset "C-1")
(keymap-global-unset "C-2")
(keymap-global-set "C-1" 'tab-previous)
(keymap-global-set "C-2" 'tab-next)
(keymap-global-set "C-x g" 'magit)

(use-package org-modern
  ;;(with-eval-after-load 'org (global-org-modern-mode)))
  :hook (after-init . global-org-modern-mode))

(use-package emojify
  :hook (after-init . global-emojify-mode))

(require 'vertico-posframe)
(vertico-posframe-mode 1)

 (defun toggle-transparency ()
   (interactive)
   (let ((alpha (frame-parameter nil 'alpha)))
     (set-frame-parameter
      nil 'alpha
      (if (eql (cond ((numberp alpha) alpha)
                     ((numberp (cdr alpha)) (cdr alpha))
                     ;; Also handle undocumented (<active> <inactive>) form.
                     ((numberp (cadr alpha)) (cadr alpha)))
               100)
          '(85 . 50) '(100 . 100)))))
(global-set-key (kbd "C-c t") 'toggle-transparency)

  ;; Fonts
  (set-face-attribute 'default nil :font "Monofur NF-16" :weight 'Book)
  (set-face-attribute 'fixed-pitch nil :font "Monofur NF-16" :weight 'Book)
  (set-face-attribute 'variable-pitch nil :font "JetBrains Mono-11" :weight 'Light)

  (defun my-org-mode-setup ()
    "Custom configuration for Org mode."
    (variable-pitch-mode 1)
    (mapc
     (lambda (face) ;; Set font faces for headings, blocks, and bullets
       (set-face-attribute face nil :font "JetBrains Mono-11" :weight 'Light))
     (list 'org-level-1
           'org-level-2
           'org-level-3
           'org-level-4
           'org-level-5
           'org-level-6
           'org-level-7
           'org-level-8
           'org-quote
           'org-verbatim
           'org-list-dt
           'org-checkbox)))

  (add-hook 'org-mode-hook 'my-org-mode-setup) ;; Apply configuration to Org mode files

  (defun conf/org-font-setup ()
    "Setup fixed-pitch font for Org."
    (custom-set-faces
     '(org-block ((t (:inherit fixed-pitch))))
     '(org-table ((t (:inherit fixed-pitch))))
     '(org-formula ((t (:inherit fixed-pitch))))
     '(org-code ((t (:inherit fixed-pitch))))
     '(org-verbatim ((t (:inherit fixed-pitch))))
     '(org-special-keyword ((t (:inherit fixed-pitch))))
     '(org-checkbox ((t (:inherit fixed-pitch))))
     '(line-number ((t (:inherit fixed-pitch))))
     '(line-number-current-line ((t (:inherit fixed-pitch))))
     '(org-block-begin-line ((t (:inherit fixed-pitch))))
     '(org-block-end-line ((t (:inherit org-block-begin-line))))))

  (add-to-list 'org-mode-hook #'conf/org-font-setup)


(use-package edwina
  :ensure t
  :config
  (setq display-buffer-base-action '(display-buffer-below-selected))
  ;; (edwina-setup-dwm-keys)
  (edwina-mode 1))

(setq-default mode-line-format (delq 'mode-line-modes mode-line-format))

(setq global-visual-line-mode t)

(setq global-display-line-numbers-mode t)

(use-package dashboard
  :ensure t 
  :init
  (setq initial-buffer-choice 'dashboard-open)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-banner-logo-title "Emacs Is More Than A Text Editor!")
  ;;(setq dashboard-startup-banner 'logo) ;; use standard emacs logo as banner
  (setq dashboard-startup-banner "~/.emacs.d/system-crafters-logo.png")  ;; use custom image as banner
  (setq dashboard-center-content nil) ;; set to 't' for centered content
  (setq dashboard-items '((recents . 5)
                          (agenda . 5)
                          (bookmarks . 3)
                          (projects . 3)
                          (registers . 3)))
  :custom 
  (dashboard-modify-heading-icons '((recents . "file-text")
				      (bookmarks . "book")))
  :config
  (dashboard-setup-startup-hook))

(defun dashboard-insert-agenda (&rest _)
  "Insert a copy of org-agenda buffer."
  (insert (save-window-excursion
            (org-agenda-list)
            (prog1 (buffer-string)
              (kill-buffer)))))

(setq dashboard-mode t)
(setq dashboard-set-file-icons t)

(setq valign-mode t)

(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode))


(setopt fill-column 80
        sentence-end-double-space nil
        indent-tabs-mode nil  ; Use spaces instead of tabs
        tab-width 4)


(use-package pixel-scroll
  :ensure nil
  :custom
  (pixel-scroll-precision-interpolation-factor 1.0)
  :bind
  (([remap scroll-up-command]   . fk/pixel-scroll-up-command)
   ([remap scroll-down-command] . fk/pixel-scroll-down-command)
   ([remap recenter-top-bottom] . fk/pixel-recenter-top-bottom))
  :hook
  (dashboard-after-initialize . pixel-scroll-precision-mode)
  :config
  (defun fk/pixel-scroll-up-command ()
    "Similar to `scroll-up-command' but with pixel scrolling."
    (interactive)
    (pixel-scroll-precision-interpolate (- (* fk/default-scroll-lines (line-pixel-height)))))

  (defun fk/pixel-scroll-down-command ()
    "Similar to `scroll-down-command' but with pixel scrolling."
    (interactive)
    (pixel-scroll-precision-interpolate (* fk/default-scroll-lines (line-pixel-height))))

  (defun fk/pixel-recenter-top-bottom ()
    "Similar to `recenter-top-bottom' but with pixel scrolling."
    (interactive)
    (let* ((current-row (cdr (nth 6 (posn-at-point))))
           (target-row (save-window-excursion
                         (recenter-top-bottom)
                         (cdr (nth 6 (posn-at-point)))))
           (distance-in-pixels (* (- target-row current-row) (line-pixel-height))))
      (pixel-scroll-precision-interpolate distance-in-pixels))))


;; (use-package xwwp-full
;;   :load-path "~/.emacs.d/xwwp"
;;   :custom
;;   (xwwp-follow-link-completion-system 'helm)
;;   :bind (:map xwidget-webkit-mode-map
;;               ("v" . xwwp-follow-link)
;;               ("t" . xwwp-ace-toggle)))


(use-package activity
  :load-path "~/.emacs.d/activity.el"
  :config
  (activity-mode))

(use-package activity-tabs
  :load-path "~/.emacs.d/activity.el"
  :config
  (activity-tabs-mode))

;; (add-to-list 'load-path "~/.emacs.d/activity.el/")
;; (require 'activity.el
;;   :config
;;   ;; Automatically save activities' states when Emacs is idle and upon
;;   ;; exit.
;;   (activity-mode)
;;   ;; Open activities in `tab-bar' tabs (otherwise frames are used, but
;;   ;; the author doesn't test that as much).
;;   (activity-tabs-mode))

;; Put backup files neatly away
(let ((backup-dir "~/Dropbox/org/Backups/")
     (auto-saves-dir "~/Dropbox/org/Backups/auto-saves/"))
 (dolist (dir (list backup-dir auto-saves-dir))
   (when (not (file-directory-p dir))
     (make-directory dir t)))
 (setq backup-directory-alist `(("." . ,backup-dir))
       auto-save-file-name-transforms `((".*" ,auto-saves-dir t))
       auto-save-list-file-prefix (concat auto-saves-dir ".saves-")
       tramp-backup-directory-alist `((".*" . ,backup-dir))
       tramp-auto-save-directory auto-saves-dir))

(setq backup-by-copying t    ; Don't delink hardlinks
     delete-old-versions t  ; Clean up the backups
     version-control t      ; Use version numbers on backups,
     kept-new-versions 5    ; keep some new versions
     kept-old-versions 2)   ; and some old ones, too

(provide 'gt-ui-config)
;;; gt-ui-config.el ends here
