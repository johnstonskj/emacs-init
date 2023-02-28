;;; skj-ui.el --- Generic UI tweaks -*- lexical-binding: t; -*-

;;; Code:

(init-message "Setting up common UI" 'skj-ui)

;; --------------------------------------------------------------------------
;; Generic Customization

(set-language-environment "UTF-8")

(setq
 echo-keystrokes 0.5
 inhibit-startup-screen t
 ring-bell-function 'ignore
 scroll-bar-mode nil
 scroll-margin 1
 scroll-step 1)

(setq-default
 fill-column 78
 indent-tabs-mode nil
 indicate-empty-lines t
 tab-always-indent 'complete
 tab-width 4)

(tool-bar-mode nil)

;; Save place in files between Sessions
(save-place-mode 1)

(when (>= (emacs-major-version) 29)
  (setq pixel-scroll-precision-mode 1))


;; --------------------------------------------------------------------------
;; Set the global theme

(init-message "ui > themes" 'skj-ui)

(skj-package-install 'color-theme-sanityinc-solarized)

(require 'color-theme-sanityinc-solarized)

(setq
 color-theme-is-global t
 custom-enabled-themes '(sanityinc-solarized-light)
 custom-safe-themes
 '("4cf3221feff536e2b3385209e9b9dc4c2e0818a69a1cdb4b522756bcdf4e00a4" default))

(color-theme-sanityinc-solarized-light)


;; --------------------------------------------------------------------------
;; Buffer Tools

(init-message "ui > buffers" 'skj-ui)

(require 'skj-packages)

(skj-package-install
 '(buffer-move
   ibuffer-sidebar))

(global-set-key (kbd "C-x C-b") 'ibuffer-sidebar-toggle-sidebar)

(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))


;; --------------------------------------------------------------------------
;; Multiple Cursor support

(init-message "ui > cursors" 'skj-ui)

(skj-package-install
 '(multicolumn
   multiple-cursors
   mc-extras))

(require 'multiple-cursors)

(global-set-key (kbd "C-c m c") 'mc/edit-lines)


;; --------------------------------------------------------------------------
;; Include icons when in a graphical frame

(init-message "ui > icons" 'skj-ui)

(skj-package-install
 '(all-the-icons
   all-the-icons-completion
   all-the-icons-dired))

(when (display-graphic-p)
  (require 'all-the-icons))
;; M-x all-the-icons-install-fonts


;; --------------------------------------------------------------------------
;; Set the mode line

(init-message "ui > mode-line" 'skj-ui)

(skj-package-install
 '(mode-icons
   major-mode-icons))

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
;; Mouse

(init-message "ui > mouse" 'skj-ui)

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
;; Nicer file/tree view

(skj-package-install '(dir-treeview dired-sidebar))

(require 'dir-treeview)

(setq dir-treeview-show-in-side-window t)

(global-set-key (kbd "<f9>") 'dir-treeview)

(load-theme 'dir-treeview-pleasant t)


;; --------------------------------------------------------------------------
;; Scratch buffer

(skj-package-install 'everlasting-scratch)

(require 'everlasting-scratch)

(add-hook 'after-init-hook 'everlasting-scratch-mode)


;; --------------------------------------------------------------------------
;; Undo tree

(skj-package-install 'undo-tree)

(require 'undo-tree)

(global-undo-tree-mode)


;; --------------------------------------------------------------------------
;; Set default mode

(setq-default major-mode 'text-mode)

(add-hook 'text-mode-hook 'auto-fill-mode)


(provide 'skj-ui)
;;; skj-ui.el ends here
