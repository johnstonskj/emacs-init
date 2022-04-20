;;; skj-prog-ui.el -*- lexical-binding: t; -*-

(init-message "Setting up common programming UI" 'skj-prog-ui)

(defcustom
  skj/project-root-dir
  (expand-file-name "~/Projects")
  "Root directory for development projects."
  :tag "Projects' root directory"
  :group 'skj
  :type 'directory)

;; --------------------------------------------------------------------------
;; Prettify Symbols

(add-hook 'scheme-mode-hook #'prettify-symbols-mode)

;; --------------------------------------------------------------------------
;; Rainbow delimiters, yes!

(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; --------------------------------------------------------------------------
;; Indentation

(require 'highlight-indent-guides)

(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)

(require 'aggressive-indent)

(add-hook 'emacs-lisp-mode-hook #'aggressive-indent-mode)
(add-hook 'css-mode-hook #'aggressive-indent-mode)

;; --------------------------------------------------------------------------
;; Add a nicer tree view

(require 'dir-treeview)
(setq dir-treeview-show-in-side-window t)

(global-set-key (kbd "<f9>") 'dir-treeview)

(load-theme 'dir-treeview-pleasant t)

;; --------------------------------------------------------------------------
;; Company completion

(require 'company)
(setq company-files-exclusions '(".git/" ".DS_Store"))
(setq company-tooltip-align-annotations t)

(add-hook 'after-init-hook 'global-company-mode)

(add-hook 'web-mode-hook
          (lambda ()
            (set (make-local-variable 'company-backends) '(company-web-html))
            (company-mode t)))

;; --------------------------------------------------------------------------
;; Magit

(require 'magit)

(setq magit-completing-read-function 'ivy-completing-read)

(provide 'skj-prog-ui)
