;;; skj-prog-snippet.el -*- lexical-binding: t; -*-

(init-message "Setting up snippets" 'skj-prog-snippet)

(require 'skj-prog-ui)

(defcustom
  skj/snippet-repo-dir
  (concat-path skj/project-root-dir "emacs-snippets")
  "Snippet repository local path."
  :tag "Snippet repository local path"
  :group 'skj
  :type 'directory)

;; --------------------------------------------------------------------------
;; yasnippet is the core here

(require 'yasnippet)

(dolist (path (list
               (concat-path user-emacs-directory "snippets")
               (concat-path org-directory "snippets")
               skj/snippet-repo-dir))
  (unless (member path yas-snippet-dirs)
    (init-message (format "Adding %s to yas-snippet-dirs" path) 'skj-prog-snippets)
    (setq yas-snippet-dirs
          (cons path yas-snippet-dirs))))

(init-message yas-snippet-dirs 'skj-prog-snippets)

(yas-global-mode 1)

(add-hook 'prog-mode-hook #'yas-minor-mode)

;; --------------------------------------------------------------------------
;; Individual package configuration

(require 'yasnippet)

(require 'gitignore-snippets)
(gitignore-snippets-init)

;; on changes: yas-reload-all

(provide 'skj-prog-snippet)
