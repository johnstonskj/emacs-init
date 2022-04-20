;;; skj-prog-rest.el -*- lexical-binding: t; -*-

(init-message "[skj-prog-rest] Entered")

(with-eval-after-load 'org
  (define-key org-mode-map (kbd "C-c C-r") verb-command-map))

(provide 'skj-prog-rest)
