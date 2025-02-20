;; Disable the splash screen (to enable it agin, replace the t with 0)
(setq inhibit-splash-screen t)

;; Enable transient mark mode
(transient-mark-mode 1)

;; Performance tweaks for modern machines
(setq gc-cons-threshold 100000000) ; 100 mb
(setq read-process-output-max (* 1024 1024)) ; 1mb

;; Remove extra UI clutter by hiding the scrollbar, menubar, and toolbar.
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; linenumbers
(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative)

;; font
(add-to-list 'default-frame-alist '(font . "FiraCode Nerd Font Mono-42" ))
(set-face-attribute 'default t :font "FiraCode Nerd Font Mono-42" )

;; backup files
(setq backup-directory-alist `(("." . "~/.cache/emacs/saves")))

;; org mode
(use-package org
      :ensure t
      :config
      (require 'org)
      (add-hook 'org-mode-hook 'org-indent-mode)
      ;; Make Org mode work with files ending in .org
      (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

      (setq org-image-actual-width nil)

      (use-package org-cliplink
            :ensure t
            :config
            (evil-leader/set-key "m p l" 'org-cliplink))

      (use-package org-modern
            :ensure t
            :config
            (with-eval-after-load 'org (global-org-modern-mode)))

      (use-package org-present
            :ensure t))

;; evil mode
(setq evil-want-C-u-scroll t)
(setq evil-want-C-u-delete t)
(use-package evil
      :ensure t
      :config
      (evil-mode 1)
      (evil-define-key 'normal 'org-present-mode [right] 'org-present-next)
      (evil-define-key 'normal 'org-present-mode [left] 'org-present-prev)
      (define-key evil-motion-state-map (kbd "C-u") 'evil-scroll-up)
      (use-package evil-leader
            :ensure t
            :config
            (global-evil-leader-mode t)
            (evil-leader/set-leader "<SPC>"))
            (evil-leader/set-key "q" 'kill-buffer)

      (use-package evil-org
            :ensure t
            :config
            (evil-org-set-key-theme
            '(textobjects insert navigation additional shift todo heading))
            (add-hook 'org-mode-hook (lambda () (evil-org-mode))))

      (use-package powerline-evil
            :ensure t
            :config
            (powerline-evil-vim-color-theme)))


;; text-scale
(use-package default-text-scale
      :ensure t
      :config
      (default-text-scale-mode 1))

;; colorscheme
(use-package doom-themes
      :ensure t
      :config
      (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
            doom-themes-enable-italic t) ; if nil, italics is universally disabled
      (load-theme 'doom-one t)
      (doom-themes-org-config))

;; fzf
(use-package fzf
      :ensure t
      :config
      (evil-leader/set-key
            "f d" 'fzf-directory
            "f f" 'fzf-find-file
            "f r" 'fzf-recentf
            "f t" 'fzf-grep
            "f s" 'fzf-grep-in-dir)
      (recentf-mode 1)
      (setq recentf-max-menu-items 25)
      (setq recentf-max-saved-items 25)
      (setq fzf/args "-x --color bw --print-query --margin=1,0 --no-hscroll"
            fzf/executable "fzf"
            fzf/git-grep-args "-i --line-number %s"
            ;; command used for `fzf-grep-*` functions
            ;; example usage for ripgrep:
            ;; fzf/grep-command "rg --no-heading -nH"
            fzf/grep-command "grep -nrH"
            ;; If nil, the fzf buffer will appear at the top of the window
            fzf/position-bottom t
            fzf/window-height 15))
