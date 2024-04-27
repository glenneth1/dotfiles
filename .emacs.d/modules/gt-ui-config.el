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
(load-theme 'spacemacs-dark)

(setq user-full-name "Glenn Thompson"
      user-mail-address "Glenn@kirstol.org")

;; (setq org-directory "~/Dropbox/org/")

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(tab-bar-mode 1)

;; (server-start)

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
(keymap-global-set "C-c r c" 'erc-sr-ht)
(keymap-global-unset "C-1")
(keymap-global-unset "C-2")
(keymap-global-set "C-1" 'tab-previous)
(keymap-global-set "C-2" 'tab-next)
(keymap-global-set "C-x g" 'magit)
(keymap-global-set "C-c c r" 'comment-region)
(keymap-global-set "C-c c u" 'uncomment-region)
(keymap-global-set "C-x C-a a" 'activities-resume)
(keymap-global-set "C-x C-a C-a" 'activities-resume)
(keymap-global-set "C-x C-a RET" 'activities-switch)
(keymap-global-set "C-x C-a g" 'activities-revert)
(keymap-global-set "C-x C-a n" 'activities-new)
(keymap-global-set "C-x C-a l" 'activities-list)
(keymap-global-set "C-x C-a s" 'activities-suspend)
(keymap-global-set "C-x C-a C-k" 'activities-kill)
(keymap-global-set "C-x C-a d" 'activities-discard)

(global-set-key [remap dabbrev-expand] 'hippie-expand)

(use-package org-modern
  ;;(with-eval-after-load 'org (global-org-modern-mode)))
  :hook (after-init . global-org-modern-mode))

(use-package emojify
  :hook (after-init . global-emojify-mode))

(require 'vertico-posframe)
(vertico-posframe-mode 1)

;; Transparency
(defvar nao/alpha-background 90)
(set-frame-parameter nil 'alpha-background nao/alpha-background)

(defun nao/toggle-alpha-background ()
  "Toggle alpha-background between 70 and 100."
  (interactive)
  (cond ((= nao/alpha-background 70) (setq nao/alpha-background 80))
        ((= nao/alpha-background 80) (setq nao/alpha-background 90))
        ((= nao/alpha-background 90) (setq nao/alpha-background 100))
        ((= nao/alpha-background 100) (setq nao/alpha-background 70)))
  (set-frame-parameter nil 'alpha-background nao/alpha-background))

(global-set-key (kbd "C-c t") 'nao/toggle-alpha-background)

;; (defun toggle-transparency ()
;;   (interactive)
;;   (let ((alpha (frame-parameter nil 'alpha)))
;;     (set-frame-parameter
;;      nil 'alpha
;;      (if (eql (cond ((numberp alpha) alpha)
;;                     ((numberp (cdr alpha)) (cdr alpha))
;;                     ;; Also handle undocumented (<active> <inactive>) form.
;;                     ((numberp (cadr alpha)) (cadr alpha)))
;;               100)
;;          '(85 . 50) '(100 . 100)))))
;; (global-set-key (kbd "C-c t") 'toggle-transparency)

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
  (setq dashboard-items '((recents . 8)
                          (agenda . 12)
                          (bookmarks . 5)
                          (projects . 8)
                          (registers . 5)))
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

(use-package recentf
  :config
  ;; Initialize recentf or ensure it's started
  (recentf-mode 1)
  ;; Exclude all files within the `org-agenda-files` list
  (setq recentf-exclude (list (lambda (filename)
                                (member filename org-agenda-files)))))

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


(use-package activities)

(use-package activities-tabs)

:config
;; Automatically save activities' states when Emacs is idle and upon
;; exit.
(activities-mode)
;; Open activities in `tab-bar' tabs (otherwise frames are used, but
;; the author doesn't test that as much).
(activities-tabs-mode)

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

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "nyxt")

(require 'meow)
;; (meow-setup)
(meow-global-mode 1)

(defun meow-setup ()
  (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)
  (meow-motion-overwrite-define-key
   '("j" . meow-next)
   '("k" . meow-prev)
   '("<escape>" . ignore))
  (meow-leader-define-key
   ;; SPC j/k will run the original command in MOTION state.
   '("j" . "H-j")
   '("k" . "H-k")
   ;; Use SPC (0-9) for digit arguments.
   '("1" . meow-digit-argument)
   '("2" . meow-digit-argument)
   '("3" . meow-digit-argument)
   '("4" . meow-digit-argument)
   '("5" . meow-digit-argument)
   '("6" . meow-digit-argument)
   '("7" . meow-digit-argument)
   '("8" . meow-digit-argument)
   '("9" . meow-digit-argument)
   '("0" . meow-digit-argument)
   '("/" . meow-keypad-describe-key)
   '("?" . meow-cheatsheet))
  (meow-normal-define-key
   '("0" . meow-expand-0)
   '("9" . meow-expand-9)
   '("8" . meow-expand-8)
   '("7" . meow-expand-7)
   '("6" . meow-expand-6)
   '("5" . meow-expand-5)
   '("4" . meow-expand-4)
   '("3" . meow-expand-3)
   '("2" . meow-expand-2)
   '("1" . meow-expand-1)
   '("-" . negative-argument)
   '(";" . meow-reverse)
   '("," . meow-inner-of-thing)
   '("." . meow-bounds-of-thing)
   '("[" . meow-beginning-of-thing)
   '("]" . meow-end-of-thing)
   '("a" . meow-append)
   '("A" . meow-open-below)
   '("b" . meow-back-word)
   '("B" . meow-back-symbol)
   '("c" . meow-change)
   '("d" . meow-delete)
   '("D" . meow-backward-delete)
   '("e" . meow-next-word)
   '("E" . meow-next-symbol)
   '("f" . meow-find)
   '("g" . meow-cancel-selection)
   '("G" . meow-grab)
   '("h" . meow-left)
   '("H" . meow-left-expand)
   '("i" . meow-insert)
   '("I" . meow-open-above)
   '("j" . meow-next)
   '("J" . meow-next-expand)
   '("k" . meow-prev)
   '("K" . meow-prev-expand)
   '("l" . meow-right)
   '("L" . meow-right-expand)
   '("m" . meow-join)
   '("n" . meow-search)
   '("o" . meow-block)
   '("O" . meow-to-block)
   '("p" . meow-yank)
   '("q" . meow-quit)
   '("Q" . meow-goto-line)
   '("r" . meow-replace)
   '("R" . meow-swap-grab)
   '("s" . meow-kill)
   '("t" . meow-till)
   '("u" . meow-undo)
   '("U" . meow-undo-in-selection)
   '("v" . meow-visit)
   '("w" . meow-mark-word)
   '("W" . meow-mark-symbol)
   '("x" . meow-line)
   '("X" . meow-goto-line)
   '("y" . meow-save)
   '("Y" . meow-sync-grab)
   '("z" . meow-pop-selection)
   '("'" . repeat)
   '("<escape>" . ignore)))

(use-package easy-hugo
  :init
  (setq easy-hugo-basedir "~/blog/")
  (setq easy-hugo-url "https://glenneth1.github.io/")
  ;; (setq easy-hugo-sshdomain "blogdomain")
  (setq easy-hugo-root "/home/glenn/blog/")
  (setq easy-hugo-previewtime "300"))
;;   :bind ("C-c C-e" . easy-hugo))

(use-package dired
  :ensure nil
  :config
  (setq dired-listing-switches "-agho --group-directories-first"
        dired-omit-files "^\\.[^.].*"
        dired-omit-verbose nil
        dired-dwim-target 'dired-dwim-target-next
        dired-hide-details-hide-symlink-targets nil
        dired-kill-when-opening-new-dired-buffer t
        delete-by-moving-to-trash t))

(use-package dired-rainbow
  :after dired
  :config
  (progn
    (dired-rainbow-define-chmod directory "#6cb2eb" "d.*")
    (dired-rainbow-define html "#eb5286" ("css" "less" "sass" "scss" "htm" "html" "jhtm" "mht" "eml" "mustache" "xhtml"))
    (dired-rainbow-define xml "#f2d024" ("xml" "xsd" "xsl" "xslt" "wsdl" "bib" "json" "msg" "pgn" "rss" "yaml" "yml" "rdata"))
    (dired-rainbow-define document "#9561e2" ("docm" "doc" "docx" "odb" "odt" "pdb" "pdf" "ps" "rtf" "djvu" "epub" "odp" "ppt" "pptx"))
    (dired-rainbow-define markdown "#ffed4a" ("org" "etx" "info" "markdown" "md" "mkd" "nfo" "pod" "rst" "tex" "textfile" "txt"))
    (dired-rainbow-define database "#6574cd" ("xlsx" "xls" "csv" "accdb" "db" "mdb" "sqlite" "nc"))
    (dired-rainbow-define media "#de751f" ("mp3" "mp4" "MP3" "MP4" "avi" "mpeg" "mpg" "flv" "ogg" "mov" "mid" "midi" "wav" "aiff" "flac"))
    (dired-rainbow-define image "#f66d9b" ("tiff" "tif" "cdr" "gif" "ico" "jpeg" "jpg" "png" "psd" "eps" "svg"))
    (dired-rainbow-define log "#c17d11" ("log"))
    (dired-rainbow-define shell "#f6993f" ("awk" "bash" "bat" "sed" "sh" "zsh" "vim"))
    (dired-rainbow-define interpreted "#38c172" ("py" "ipynb" "rb" "pl" "t" "msql" "mysql" "pgsql" "sql" "r" "clj" "cljs" "scala" "js"))
    (dired-rainbow-define compiled "#4dc0b5" ("asm" "cl" "lisp" "el" "c" "h" "c++" "h++" "hpp" "hxx" "m" "cc" "cs" "cp" "cpp" "go" "f" "for" "ftn" "f90" "f95" "f03" "f08" "s" "rs" "hi" "hs" "pyc" ".java"))
    (dired-rainbow-define executable "#8cc4ff" ("exe" "msi"))
    (dired-rainbow-define compressed "#51d88a" ("7z" "zip" "bz2" "tgz" "txz" "gz" "xz" "z" "Z" "jar" "war" "ear" "rar" "sar" "xpi" "apk" "xz" "tar"))
    (dired-rainbow-define packaged "#faad63" ("deb" "rpm" "apk" "jad" "jar" "cab" "pak" "pk3" "vdf" "vpk" "bsp"))
    (dired-rainbow-define encrypted "#ffed4a" ("gpg" "pgp" "asc" "bfe" "enc" "signature" "sig" "p12" "pem"))
    (dired-rainbow-define fonts "#6cb2eb" ("afm" "fon" "fnt" "pfb" "pfm" "ttf" "otf"))
    (dired-rainbow-define partition "#e3342f" ("dmg" "iso" "bin" "nrg" "qcow" "toast" "vcd" "vmdk" "bak"))
    (dired-rainbow-define vc "#0074d9" ("git" "gitignore" "gitattributes" "gitmodules"))
    (dired-rainbow-define-chmod executable-unix "#38c172" "-.*x.*")
    )) 

(use-package smartparens
  :hook (prog.mode . smartparens-mode)
  :config
  (sp-use-smartparens-bindings))

(require 'undo-tree)
(global-undo-tree-mode)

(provide 'gt-ui-config)
;;; gt-ui-config.el ends here
