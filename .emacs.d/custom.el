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
   '("5f128efd37c6a87cd4ad8e8b7f2afaba425425524a68133ac0efd87291d05874"
     "02f57ef0a20b7f61adce51445b68b2a7e832648ce2e7efb19d217b6454c1b644"
     default))
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
     "https://irreal.org/blog/?feed=rss2"
     "https://www.reddit.com/r/orgmode.rss"
     "https://www.reddit.com/r/emacs.rss"))
 '(ement-room-avatar-max-height 64)
 '(ement-room-avatar-max-width 64)
 '(ement-room-message-format-spec "[%t] %S> %W%B%r" nil (ement-room))
 '(ement-room-send-message-filter 'ement-room-send-org-filter)
 '(eshell-scroll-to-bottom-on-input 'this t)
 '(evil-respect-visual-line-mode t)
 '(evil-undo-system 'undo-redo)
 '(evil-want-C-h-delete t)
 '(evil-want-C-i-jump nil)
 '(evil-want-integration t)
 '(evil-want-keybinding nil)
 '(fancy-splash-image "/home/glenn/.emacs.d/system-crafters-logo.png")
 '(fast-but-imprecise-scrolling t)
 '(global-auto-revert-non-file-buffers t)
 '(ibuffer-movement-cycle nil)
 '(ibuffer-old-time 24)
 '(kill-do-not-save-duplicates t)
 '(libmpdel-music-directory "/home/glenn/Music/")
 '(libmpdel-port 6600)
 '(libmpdel-profiles '(("Local server" "localhost" 6700 ipv4)))
 '(load-prefer-newer t t)
 '(marginalia-annotators
   '(marginalia-annotators-heavy marginalia-annotators-light nil) t)
 '(org-agenda-files
   '("/home/glenn/Dropbox/org/PersonalTasks.org"
     "/home/glenn/Dropbox/org/WorkFlow.org"
     "/home/glenn/Dropbox/org/org-gtd/org-gtd-tasks.org"))
 '(org-hide-emphasis-markers t)
 '(org-link-descriptive t)
 '(org-mouse-1-follows-link t)
 '(org-return-follows-link t)
 '(package-archive-priorities
   '(("gnu" . 99) ("nongnu" . 80) ("stable" . 70) ("melpa" . 0)))
 '(package-selected-packages nil)
 '(podcaster-feeds-urls
   '("https://feeds.fireside.fm/kernelpanic/rss"
     "https://feeds.megaphone.fm/the-pitchfork-review"
     "https://sachachua.com/blog/category/podcast/all/"))
 '(scroll-conservatively 101)
 '(scroll-margin 0)
 '(scroll-preserve-screen-position t)
 '(switch-to-buffer-in-dedicated-window 'pop)
 '(switch-to-buffer-obey-display-actions t)
 '(tab-always-indent 'complete)
 '(vertico-cycle t)
 '(xref-show-definitions-function 'xref-show-definitions-completing-read t))
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
