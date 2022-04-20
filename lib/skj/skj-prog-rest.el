;;; skj-prog-rest.el -*- lexical-binding: t; -*-

(init-message "Setting up org/rest mode" 'skj-prog-rest)

(with-eval-after-load 'org
  (define-key org-mode-map (kbd "C-c C-r") verb-command-map))

(provide 'skj-prog-rest)
