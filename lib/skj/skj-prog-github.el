;;; skj-prog-github.el -*- lexical-binding: t; -*-

(init-message "[skj-prog-github] Entered")

(require 'file-secrets)

(defvar
  skj-github-token
  (read-secret-from-file (expand-file-name "~/.config/github-token"))
  "Personal GitHub token, NOT included in repository")

(setq github-notifier-token skj-github-token)

(add-hook 'prog-mode-hook #'github-notifier-mode)

(provide 'skj-prog-github)
