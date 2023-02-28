;;; skj-snippets.el --- Snippet configuration -*- lexical-binding: t; -*-

;;; Code:

(init-message "Setting up snippets" 'skj-snippets)


;; --------------------------------------------------------------------------
;; yasnippet is the core here

(require 'skj-packages)

(skj-package-install
 '(yasnippet
   yasnippet-snippets
   gitignore-snippets
   license-snippets
   ivy-yasnippet))

(require 'yasnippet)
(require 'skj-dirs)

(dolist (path (list
               (concat-path user-emacs-directory "snippets")
               (concat-path org-directory "snippets")
               skj-snippet-repo-dir))
  (unless (member path yas-snippet-dirs)
    (init-message (format "Adding %s to yas-snippet-dirs" path) 'skj-prog-snippets)
    (setq yas-snippet-dirs
          (cons path yas-snippet-dirs))))

(init-message yas-snippet-dirs 'skj-snippets)

(yas-global-mode 1)

(add-hook 'prog-mode-hook #'yas-minor-mode)

;; --------------------------------------------------------------------------
;; Individual package configuration

(require 'gitignore-snippets)

(gitignore-snippets-init)

;; on changes: yas-reload-all

(provide 'skj-snippets)
;;; skj-snippets.el ends here
