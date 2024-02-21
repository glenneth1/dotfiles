(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(Man-notify-method 'aggressive t)
 '(bookmark-save-flag 1)
 '(completion-category-overrides '((file (styles partial-completion))))
 '(completion-cycle-threshold 3)
 '(completion-styles '(orderless basic))
 '(completions-detailed t)
 '(corfu-auto t)
 '(corfu-auto-prefix 2)
 '(corfu-cycle t)
 '(custom-safe-themes
   '("5f128efd37c6a87cd4ad8e8b7f2afaba425425524a68133ac0efd87291d05874" default))
 '(dired-auto-revert-buffer t)
 '(dired-dwim-target t)
 '(ediff-window-setup-function 'ediff-setup-windows-plain t)
 '(eglot-autoshutdown t t)
 '(elfeed-feeds
   '("https://en.royanews.tv/rss" "http://feeds.bbci.co.uk/news/rss.xml"
     "https://sachachua.com/blog/feed"
     "https://sachachua.com/blog/2003/08/rss-feed/"
     "https://feeds.megaphone.fm/the-pitchfork-review"
     "indieisnotagenre.com/feed" "https://www.reddit.com/r/linux/.rss"
     "https://systemcrafters.net/rss/news.xml"
     "https://irreal.org/blog/?feed=rss2" "https://www.reddit.com/r/orgmode.rss"
     "https://www.reddit.com/r/emacs.rss"))
 '(eshell-scroll-to-bottom-on-input 'this t)
 '(fancy-splash-image "/home/glenn/.emacs.d/system-crafters-logo.png")
 '(fast-but-imprecise-scrolling t)
 '(global-auto-revert-non-file-buffers t)
 '(ibuffer-movement-cycle nil)
 '(ibuffer-old-time 24)
 '(kill-do-not-save-duplicates t)
 '(load-prefer-newer t t)
 '(marginalia-annotators
   '(marginalia-annotators-heavy marginalia-annotators-light nil) t)
 '(org-agenda-files
   '("~/Dropbox/org/TFS/R&R.org"
     "/home/glenn/Dropbox/org/org-gtd/org-gtd-tasks.org"
     "/home/glenn/Dropbox/org/WorkFlow.org"
     "/home/glenn/Dropbox/org/PersonalTasks.org"))
 '(org-hide-emphasis-markers t)
 '(org-link-descriptive t)
 '(org-mouse-1-follows-link t)
 '(org-return-follows-link t)
 '(package-archive-priorities
   '(("gnu" . 99) ("nongnu" . 80) ("stable" . 70) ("melpa" . 0)))
 '(package-selected-packages
   '(0x0 activities aggressive-indent all-the-icons-nerd-fonts apheleia
         auctex-latexmk blamer bufler burly cape catppuccin-theme cdlatex
         chatgpt-shell circe company corfu-terminal dashboard denote diff-hl
         dired-preview dirvish djvu doct doom-modeline doom-themes easy-hugo eat
         editorconfig edwina elfeed-webkit elisp-demos embark-consult ement emms
         emojify epkg-marginalia erc-colorize erc-hl-nicks erc-yt ercn
         evil-collection evil-mu4e evil-nerd-commenter ffmpeg-player fireplace
         fix-word geiser-guile git-gutter hammy helpful highlight-indent-guides
         hyperbole hyperdrive ibuffer-project ivy-mpdel ix latex-preview-pane
         magit markdown-mode mastodon mu4e-alert nerd-icons-dired
         nerd-icons-ivy-rich nov ob-sagemath orderless org-appear org-bullets
         org-contacts org-fancy-priorities org-gtd org-mime org-modern
         org-noter-pdftools org-projectile org-protocol-jekyll org-ql
         org-superstar org-web-tools ox-hugo ox-pandoc pandoc pandoc-mode
         podcaster prettier prism quelpa-use-package rainbow-delimiters
         seriestracker svg-tag-mode swiper tabspaces telega toc-org
         tree-sitter-langs treesit-auto valign vertico-posframe vterm
         which-key-posframe xenops yasnippet-snippets yequake zoxide))
 '(rcirc-authinfo
   '(("100.98.92.133" nickserv "glenneth" "glenneth:b3l0wz3r0")))
 '(rcirc-server-alist
   '(("100.98.92.133" :port 5555 :channels ("" "") :encryption tls)))
 '(scroll-conservatively 101)
 '(scroll-margin 0)
 '(scroll-preserve-screen-position t)
 '(switch-to-buffer-in-dedicated-window 'pop)
 '(switch-to-buffer-obey-display-actions t)
 '(tab-always-indent 'complete)
 '(vertico-cycle t)
 '(xref-show-definitions-function 'xref-show-definitions-completing-read))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(line-number ((t (:inherit fixed-pitch))))
 '(line-number-current-line ((t (:inherit fixed-pitch))))
 '(org-block ((t (:inherit fixed-pitch))))
 '(org-block-begin-line ((t (:inherit fixed-pitch))))
 '(org-block-end-line ((t (:inherit org-block-begin-line))))
 '(org-checkbox ((t (:inherit fixed-pitch))))
 '(org-code ((t (:inherit fixed-pitch))))
 '(org-formula ((t (:inherit fixed-pitch))))
 '(org-special-keyword ((t (:inherit fixed-pitch))))
 '(org-table ((t (:inherit fixed-pitch))))
 '(org-verbatim ((t (:inherit fixed-pitch)))))
