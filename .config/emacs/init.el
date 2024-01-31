 ;;; init.el -*- lexical-binding: t; -*-

;; Author: marcosfpr
;; My Custom Emacs Settings

;;; General

;; Font
(set-face-attribute 'default nil :font "Iosevka-13")
(set-frame-font "Iosevka-13" nil t)

;; Load Path
(add-to-list 'load-path "~/.config/emacs/custom")

;; Theme
(load-theme 'challenger-deep)

;; Remove the start screen, use dashboard instead
(setq inhibit-startup-screen t)

;; No bells
(setq ring-bell-function 'ignore)

;; Turn off auto-save
(setq auto-save-default nil)

;; Don't want backups
(setq make-backup-files nil)

;; Remove default comment in scratch buffers
(setq initial-scratch-message nil)

;; Update files if they change externally
(global-auto-revert-mode 1)

;; Line numbers
;; set type of line numbering (global variable)
(setq display-line-numbers-type 'relative)

;; activate line numbering in all buffers/modes
(global-display-line-numbers-mode)

;; disable for specific buffers
(add-hook 'treemacs-mode-hook (lambda() (display-line-numbers-mode -1)))


(add-hook 'prog-mode-hook (lambda () (display-line-numbers-mode 1)))
(add-hook 'text-mode-hook (lambda () (display-line-numbers-mode 1)))
(add-hook 'protobuf-mode-hook (lambda () (display-line-numbers-mode 1)))

(defalias 'yes-or-no-p 'y-or-n-p)

;; Always follow symlinks
(setq vc-follow-symlinks t)

;; UTF-8 always
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)


;; Make Emacs behave like every other app when overwriting text.
(delete-selection-mode 1)

;; Show left fringe only
(fringe-mode '(4 . 0))

;; Set GC to 100mb
(setq gc-cons-threshold 100000000)

;; Allow larger process payloads to be read
(setq read-process-output-max (* 1024 1024)) ;; 1mb

;; Never tabs
(setq-default indent-tabs-mode nil)

;; Prevent the creation of backup files
(setq make-backup-files nil)

;; Turn off scroll bars
(scroll-bar-mode -1)

;; Turn off tool bar
(tool-bar-mode -1)

;; Turn off the menu bar
(menu-bar-mode -1)

;; No blinking cursors
(blink-cursor-mode 0)

;; Show cursor coordinates
(column-number-mode 1)

;; Start maximised
(toggle-frame-maximized)


;; Always want packages to be fetched if not present
(setq straight-use-package-by-default t)

;; Compile packages natively
(setq package-native-compile t)

;; Reload
(defun reload-init-file ()
  (interactive)
  (load-file user-init-file))

(global-set-key (kbd "C-c C-l") 'reload-init-file)

(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("elpa" . "https://elpa.gnu.org/packages/")))

;;; BOOTSTRAP STRAIGHT

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;;; BOOTSTRAP USE-PACKAGE
(package-initialize)
(setq use-package-always-ensure t)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile (require 'use-package))

(use-package undo-fu
  :config
  (global-unset-key (kbd "C-z"))
  (global-set-key (kbd "C-z")   'undo-fu-only-undo)
  (global-set-key (kbd "C-S-z") 'undo-fu-only-redo))



;;; Vim Bindings
(use-package evil
  :demand t
  :bind (("<escape>" . keyboard-escape-quit))
  :init
  ;; allows for using cgn
  ;; (setq evil-search-module 'evil-search)
  (setq evil-want-keybinding nil)
  ;; no vim insert bindings
  (setq evil-undo-system 'undo-fu)
  :config
  (evil-mode 1))

;;; Vim Bindings Everywhere else
(use-package evil-collection
  :after evil
  :config
  (setq evil-want-integration t)
  (evil-collection-init))

(evil-set-initial-state 'dired-mode 'emacs)
(setq evil-overriding-maps nil)

;; Leader
(require 'evil-leader)
(global-evil-leader-mode)
(evil-leader/set-leader "SPC")

;;; Env vars
(use-package exec-path-from-shell
  :config
  (exec-path-from-shell-initialize))


;;; Which key
(use-package which-key
  :diminish which-key-mode
  :config
  (which-key-mode))

;; Window motions
(use-package windmove
  :config
  (windmove-default-keybindings 'S)
  (setq windmove-wrap-around t))


;; Undo/redo layouts
(winner-mode 1)

;; Drag stuff motions
(use-package drag-stuff)
(drag-stuff-global-mode 1)


;; Ivy
(use-package ivy
  :diminish ivy-mode
  :config
  (ivy-mode t)
  (setq ivy-initial-inputs-alist nil))

;;; Counsel
(use-package counsel
  :after ivy
  :custom
  (counsel-linux-app-format-function #'counsel-linux-app-format-function-name-only)
  :bind (("M-x" . counsel-M-x)
	 ("C-c r" . counsel-rg)
	 ("C-c e" . counsel-linux-app)))


;; Ivy rich
(use-package ivy-rich
  :config
  (setcdr (assq t ivy-format-functions-alist) #'ivy-format-function-line)
  (ivy-rich-mode 1))

;;; Swiper
(use-package swiper
  :bind (("C-s" . swiper)))

;; Home page
(use-package dashboard
  :config
  (setq dashboard-center-content t)
  (setq dashboard-set-footer nil)
  (setq dashboard-startup-banner 'logo)
  (setq dashboard-items '((projects . 5)
			  (recents . 5)))
  (dashboard-setup-startup-hook))

;; LSP

(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "SPC l")
  :hook
  (rust-mode . lsp)
  :config
  (setq lsp-rust-analyzer-server-display-inlay-hints t)
  (setq lsp-enable-snippet nil)
  (setq lsp-headerline-breadcrumb-enable nil)
  (setq lsp-rust-analyzer-cargo-watch-command "clippy")
  (add-to-list 'lsp-file-watch-ignored "[/\\\\]data$")
  (add-to-list 'lsp-file-watch-ignored "[/\\\\].git$")
  (add-to-list 'lsp-file-watch-ignored "[/\\\\].submodules$")
 )

(use-package lsp-ui)

(use-package lsp-ivy)

(use-package eldoc
  :diminish eldoc-mode)

(use-package dap-mode
  :commands dap-debug
  :config
  (require 'dap-go)
  (dap-go-setup)
  (require 'dap-hydra)
  (require 'dap-gdb-lldb)
  (dap-gdb-lldb-setup))


;;; Languages

;; Flycheck
(use-package flycheck
  :diminish flycheck-mode
  :config
  (flycheck-mode 1))

(use-package rainbow-delimiters
  :config
  (add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode))

;;; Whitespace
(setq require-final-newline t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;;; Parenthesis
(electric-pair-mode 1)
(show-paren-mode 1)

(use-package prettier
  :config
  :bind (("C-c C-p" . prettier-prettify)))


(use-package yasnippet
  :diminish yas-minor-mode
  :config
  (setq yas-verbosity 1)
  (setq yas-wrap-around-region t)
  (yas-reload-all)
  (yas-global-mode))

(use-package yasnippet-snippets)

(use-package rustic
  :mode ("\\.rs$" . rustic-mode)
  :ensure
  :bind (:map rustic-mode-map
              ("M-j" . lsp-ui-imenu)
              ("M-?" . lsp-find-references)
              ("C-c C-c l" . flycheck-list-errors)
              ("C-c C-c a" . lsp-execute-code-action)
              ("C-c C-c r" . lsp-rename)
              ("C-c C-c q" . lsp-workspace-restart)
              ("C-c C-c Q" . lsp-workspace-shutdown)
              ("C-c C-c s" . lsp-rust-analyzer-status))
  :config
  (setq rustic-format-trigger 'on-save)
  (setq rustic-lsp-server 'rust-analyzer)
  (setq rustic-format-display-method 'ignore)
  (add-hook 'rustic-mode-hook 'rk/rustic-mode-hook))

(defun rk/rustic-mode-hook ()
  ;; so that run C-c C-c C-r works without having to confirm, but don't try to
  ;; save rust buffers that are not file visiting. Once
  ;; https://github.com/brotzeit/rustic/issues/253 has been resolved this should
  ;; no longer be necessary.
  (when buffer-file-name
    (setq-local buffer-save-without-query t))
  (add-hook 'before-save-hook 'lsp-format-buffer nil t))


(push 'rustic-clippy flycheck-checkers)

(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp))))

;; Treesitter

(use-package tree-sitter
  :straight (tree-sitter :type git
                         :host github
                         :repo "ubolonton/emacs-tree-sitter"
                         :files ("lisp/*.el"))
  :config (add-to-list 'tree-sitter-major-mode-language-alist '(rustic-mode . rust))
  :hook ((python-mode rustic-mode) . tree-sitter-hl-mode))

(use-package tree-sitter-langs
  :straight (tree-sitter-langs :type git
                               :host github
                               :repo "ubolonton/emacs-tree-sitter"
                               :files ("langs/*.el" "langs/queries"))
  :after tree-sitter)

;; Magit
(use-package sqlite3)

(use-package magit
  :config
  (global-set-key (kbd "C-x g") 'magit-status)
  (global-set-key (kbd "C-x M-g") 'magit-dispatch))

(use-package forge
  :after magit
  :config
  (global-set-key (kbd "C-x M-f") 'forge-dispatch))

;; cargo install delta
(use-package magit-delta
  :after magit
  :hook (magit-mode . magit-delta-mode)
  :config
  (add-hook 'magit-mode-hook (lambda () (magit-delta-mode +1))))

;; Syntax highlighting for various git related files
(use-package git-modes)

(use-package diff-hl
  :config
  (global-diff-hl-mode)
  (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh))

;; Treemacs
(use-package treemacs
  :defer t
  :config
  (progn
    (setq treemacs-no-png-images t)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode t)
    (pcase (cons (not (null (executable-find "git")))
		 (not (null treemacs-python-executable)))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple))))
)

(use-package treemacs-evil
  :after (treemacs evil)
  :ensure t)

(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure t)

(use-package treemacs-icons-dired
  :hook (dired-mode . treemacs-icons-dired-enable-once)
  :ensure t)

(use-package treemacs-magit
  :after (treemacs magit)
  :ensure t)

(use-package lsp-treemacs
  :after lsp treemacs
  :config
  (lsp-treemacs-sync-mode 1))

;; Company and Projectile
(use-package company
  :diminish company-mode
  :config
  ; No delay in showing suggestions.
  (setq company-idle-delay 0.01)
  ; Show suggestions after entering one character.
  (setq company-minimum-prefix-length 1)
  ; Wrap list around
  (setq company-selection-wrap-around t))

;;; Projectile
(use-package projectile
  :diminish
  :config
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (projectile-mode +1)
  (setq projectile-completion-system 'ivy)
  (setq projectile-switch-project-action 'projectile-dired)
  (setq projectile-git-submodule-command nil)
  :bind (("C-c p f" . projectile-find-file)))


;; Bindings

(defun untab-region (N)
    (interactive "p")
    (indent-region-custom -4)
)

(defun tab-region (N)
    (interactive "p")
    (if (active-minibuffer-window)
        (minibuffer-complete)    ; tab is pressed in minibuffer window -> do completion
    ; else
    (if (string= (buffer-name) "*shell*")
        (comint-dynamic-complete) ; in a shell, use tab completion
    ; else
    (if (use-region-p)    ; tab is pressed is any other buffer -> execute with space insertion
        (indent-region-custom 4) ; region was selected, call indent-region-custom
        (insert "    ") ; else insert four spaces as expected
    )))
)

(define-key evil-visual-state-map (kbd "SPC >") 'tab-region)
(define-key evil-visual-state-map (kbd "SPC <") 'untab-region)

(define-key evil-normal-state-map (kbd "SPC e") 'treemacs)
(define-key evil-normal-state-map (kbd "SPC g s") 'magit-status)
(define-key evil-normal-state-map (kbd "SPC g d") 'magit-dispatch)

(define-key evil-visual-state-map (kbd "K") 'drag-stuff-up)
(define-key evil-visual-state-map (kbd "J") 'drag-stuff-down)



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("ed5afe11def738a452af6d1070faaa98a3e32e5a22c179e4e7c4c40ffff93478" "80214de566132bf2c844b9dee3ec0599f65c5a1f2d6ff21a2c8309e6e70f9242" "a0997c8cd72b848c675e66531265b68845cfdb222b32762ac8773c1dc957d10a" "18cf5d20a45ea1dff2e2ffd6fbcd15082f9aa9705011a3929e77129a971d1cb3" "c7c8e1670866772a055b0577027095b933057ed11ebdcccf44bae7e3756eacc0" "f5661fd54b1e60a4ae373850447efc4158c23b1c7c9d65aa1295a606278da0f8" "7809c67a87ab1c4fc5f4df85676c52a58f7503057d6c6a5b5afb20a76fb82926" "f149d9986497e8877e0bd1981d1bef8c8a6d35be7d82cba193ad7e46f0989f6a" "718dbb82a095087abd46d0e082c0c5774b8eda47719aae62437c38d00a0c3484" default))
 '(package-selected-packages
   '(prettier dap-mode lsp-ivy lsp-ui lsp-mode diff-hl forge sqlite3 treemacs-evil treemacs dashboard general ivy minibuffer-line telephone-line drag-stuff which-key exec-path-from-shell catppuccin-theme zenburn-theme material-theme faff-theme fleetish-theme evil-collection evil undo-fu)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
