;;; skj-prog-ui.el -*- lexical-binding: t; -*-

(init-message "[skj-prog-ui] Entered")

(defcustom
  skj/project-root-dir
  (expand-file-name "~/Projects")
  "Root directory for development projects."
  :tag "Projects' root directory"
  :group 'skj
  :type 'directory)

;; --------------------------------------------------------------------------
;; My stuff.

(require 'datalog-mode)

;; --------------------------------------------------------------------------
;; Prettify Symbols

(add-hook 'scheme-mode-hook #'prettify-symbols-mode)

;; --------------------------------------------------------------------------
;; Rainbow delimiters, yes!

(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

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
