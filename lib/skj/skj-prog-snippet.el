;;; skj-prog-snippet.el -*- lexical-binding: t; -*-

(init-message "[skj-prog-snippet] Entered")

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

(setq yas-snippet-dirs
      (append yas-snippet-dirs
              (list (concat-path user-emacs-directory "snippets")
                    (concat-path org-directory "snippets")
                    skj/snippet-repo-dir)))

(message "%s" yas-snippet-dirs)

(yas-global-mode 1)

(add-hook 'prog-mode-hook #'yas-minor-mode)


(provide 'skj-prog-snippet)
