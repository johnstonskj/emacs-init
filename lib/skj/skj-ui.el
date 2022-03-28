;;; skj-ui.el -*- lexical-binding: t; -*-

(init-message "[skj-ui] Entered")

(set-language-environment "UTF-8")

(setq inhibit-startup-screen t)

(setq echo-keystrokes 0.5)

(setq indent-tabs-mode nil
      tab-always-indent 'complete
      tab-width 4)

(setq fill-column 78)
      
(setq indicate-empty-lines t)

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

(buffer-expose-mode 1)

;; --------------------------------------------------------------------------
;; Set the global theme

(require 'sanityinc-solarized-light-theme)
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

(provide 'skj-ui)
