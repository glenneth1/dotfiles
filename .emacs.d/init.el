;;; init.el -*- lexical-binding: t; -*-

;;; Initial phase.

;; Load the custom file if it exists.  Among other settings, this will
;; have the list `package-selected-packages', so we need to load that
;; before adding more packages.  The value of the `custom-file'
;; variable must be set appropriately, by default the value is nil.
;; This can be done here, or in the early-init.el file.
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (and custom-file
           (file-exists-p custom-file))
  (load custom-file nil 'nomessage))

;; Adds crafted-emacs modules to the `load-path', sets up a module
;; writing template, sets the `crafted-emacs-home' variable.
(load "~/.emacs.d/modules/crafted-init-config")

;;; Packages phase

;; Collect list of packages to install.  Do not just blindly copy this
;; list, instead think about what you need and see if there is a
;; module which provides the list of packages needed.  This phase is
;; not needed if manage the installed packages with Guix or Nix.  It
;; is also not needed if you do not need Crafted Emacs to install
;; packages for a module, for example,
;; `crafted-speedbar-config' does not require any packages to
;; be installed.
(require 'crafted-completion-packages)  ; add completion packages to
                                        ; the
                                        ; `package-selected-packages'
                                        ; list
(require 'crafted-ide-packages)
(require 'crafted-evil-packages)
(require 'crafted-org-packages)
(require 'crafted-ui-packages)
(require 'crafted-writing-packages)
(require 'gt-mail-packages)
(require 'gt-org-gtd-packages)
(require 'gt-python-packages)
(require 'gt-social-packages)
(require 'gt-superagenda-packages)
(require 'gt-ui-packages)
(require 'gt-writing-packages)

;; Install the packages listed in the `package-selected-packages' list.
(package-install-selected-packages :noconfirm)

;;; Configuration phase

;; Some example modules to configure Emacs. Don't blindly copy these,
;; they are here for example purposes.  Find the modules which work
;; for you and add them here.
(require 'crafted-completion-config)
;; (require 'crafted-evil-config)
(require 'crafted-ide-config)
(require 'crafted-defaults-config)
(require 'crafted-org-config)
(require 'crafted-package-config)
(require 'crafted-startup-config)
(require 'crafted-ui-config)
(require 'crafted-updates-config)
(require 'crafted-writing-config)
(require 'gt-mail-config)
(require 'gt-org-gtd-config)
(require 'gt-python-config)
(require 'gt-social-config)
(require 'gt-superagenda-config)
(require 'gt-ui-config)
(require 'gt-writing-config)

;;; Optional configuration

;; Profile emacs startup
(defun crafted-startup-example/display-startup-time ()
  "Display the startup time after Emacs is fully initialized."
  (message "Crafted Emacs loaded in %s."
           (emacs-init-time)))
(add-hook 'emacs-startup-hook #'crafted-startup-example/display-startup-time)


(setq mastodon-instance-url "https://mstdn.social"
      mastodon-active-user "GeeTee")

(with-eval-after-load 'ox-latex
  (add-to-list 'org-latex-classes
               '("org-plain-latex"
                 "\\documentclass{article}
           [NO-DEFAULT-PACKAGES]
           [PACKAGES]
           [EXTRA]"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))

(setopt use-short-answers t)

`(customize-set-variable 'crafted-startup-inhibit-splash t)'

;; Set default coding system (especially for Windows)
(set-default-coding-systems 'utf-8)
