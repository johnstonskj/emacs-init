;;; skj-ui.el -*- lexical-binding: t; -*-

(init-message "Setting up common UI" 'skj-ui)

(set-language-environment "UTF-8")

(setq inhibit-startup-screen t)

(setq echo-keystrokes 0.5)

(setq-default indent-tabs-mode nil
              tab-always-indent 'complete
              tab-width 4)

(setq-default fill-column 78)
      
(setq-default indicate-empty-lines t)

(setq ring-bell-function 'ignore)

(setq save-place t)

(setq pixel-scroll-precision-mode 1
      scroll-bar-mode nil
      scroll-margin 1
      scroll-step 1)

(tool-bar-mode nil)

;; --------------------------------------------------------------------------
;; Buffer Tools

(require 'buffer-expose)

(global-set-key (kbd "<esc> <tab>") 'buffer-expose)

(buffer-expose-mode 1)

(require 'ibuffer-projectile)

(add-hook 'ibuffer-hook
          (lambda ()
            (ibuffer-projectile-set-filter-groups)
            (unless (eq ibuffer-sorting-mode 'alphabetic)
              (ibuffer-do-sort-by-alphabetic))))

(global-set-key (kbd "C-x C-b") 'ibuffer-sidebar-toggle-sidebar)

(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

;; --------------------------------------------------------------------------
;; Multiple Cursor support

(require 'multiple-cursors)

(global-set-key (kbd "C-c m c") 'mc/edit-lines)

;; --------------------------------------------------------------------------
;; Set the global theme

(require 'color-theme-sanityinc-solarized)

(setq
 color-theme-is-global t
 custom-enabled-themes '(sanityinc-solarized-light)
 custom-safe-themes
 '("4cf3221feff536e2b3385209e9b9dc4c2e0818a69a1cdb4b522756bcdf4e00a4" default))

(color-theme-sanityinc-solarized-light)

;; --------------------------------------------------------------------------
;; Include icons when in a graphical frame

(when (display-graphic-p)
  (require 'all-the-icons))
;; M-x all-the-icons-install-fonts

;; --------------------------------------------------------------------------
;; Set the mode line

(setq display-time-string-forms
       '((propertize (concat " " 24-hours ":" minutes " "))))

(display-time-mode t)
(line-number-mode t)
(column-number-mode t)
(display-battery-mode t)


(when (display-graphic-p)
  (require 'major-mode-icons)

  (major-mode-icons-mode 1)

  (require 'mode-icons)

  (mode-icons-mode 1))

;; --------------------------------------------------------------------------
;; Keyboard

(setq mac-command-modifier 'super)        ; make cmd key do Super
(setq mac-right-command-modifier 'super)
(setq mac-option-modifier 'meta)          ; make opt key do Meta
(setq mac-right-option-modifier 'meta)
(setq mac-control-modifier 'control)      ; make Control key do Control

(setq ns-command-modifier 'super)
(setq ns-right-command-modifier 'super)
(setq ns-alternate-modifier 'meta)
(setq ns-function-modifier 'hyper)        ; make Fn key do Hyper

;; --------------------------------------------------------------------------
;; Mouse

(require 'mouse)
(setq mouse-wheel-follow-mouse 't)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))

(xterm-mouse-mode t)

;; mouse wheel
(global-set-key [mouse-4] (lambda ()
                            (interactive)
                            (scroll-down 1)))
(global-set-key [mouse-5] (lambda ()
                            (interactive)
                            (scroll-up 1)))

;; --------------------------------------------------------------------------
;; Set default mode

(setq-default major-mode 'text-mode)
(add-hook 'text-mode-hook 'auto-fill-mode)

;; --------------------------------------------------------------------------
;; Undo tree

(require 'undo-tree)
(global-undo-tree-mode)

;; --------------------------------------------------------------------------
;; Ivy, Counsel, and Swiper

(require 'ivy)

(setq ivy-use-virtual-buffers t
      enable-recursive-minibuffers t
      ivy-count-format "(%d/%d) ")

(require 'counsel)

(setq counsel-find-file-ignore-regexp "\\(?:\\`\\|[/\\]\\)\\(?:[#.]\\)")

;; Ivy-based interface to standard commands
(global-set-key (kbd "C-s") 'swiper-isearch)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "M-y") 'counsel-yank-pop)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "<f2> j") 'counsel-set-variable)
(global-set-key (kbd "C-x b") 'ivy-switch-buffer)
(global-set-key (kbd "C-c v") 'ivy-push-view)
(global-set-key (kbd "C-c V") 'ivy-pop-view)

;; Ivy-based interface to shell and system tools
(global-set-key (kbd "C-c c") 'counsel-compile)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c L") 'counsel-git-log)
(global-set-key (kbd "C-c k") 'counsel-rg)
(global-set-key (kbd "C-c m") 'counsel-linux-app)
(global-set-key (kbd "C-c n") 'counsel-fzf)
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-c J") 'counsel-file-jump)
(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
(global-set-key (kbd "C-c w") 'counsel-wmctrl)

;; Ivy-resume (resumes the last Ivy-based completion) and other commands
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "C-c b") 'counsel-bookmark)
(global-set-key (kbd "C-c d") 'counsel-descbinds)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c o") 'counsel-outline)
(global-set-key (kbd "C-c t") 'counsel-load-theme)
(global-set-key (kbd "C-c F") 'counsel-org-file)

(ivy-mode 1)

(require 'ivy-explorer)

;; use ivy explorer for all file dialogs
(ivy-explorer-mode 1)

;; not strictly necessary
(counsel-mode 1)

(provide 'skj-ui)
