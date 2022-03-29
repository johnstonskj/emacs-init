;;; skj-prog-github.el -*- lexical-binding: t; -*-

(init-message "[skj-prog-github] Entered")

(require 'skj-secrets)

(setq github-notifier-token (skj-secrets-value 'github-token))

(add-hook 'prog-mode-hook #'github-notifier-mode)

(provide 'skj-prog-github)
