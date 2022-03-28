;;; skj-prog-snippet.el -*- lexical-binding: t; -*-

(init-message "[skj-prog-snippet] Entered")

(require 'skj-prog-ui)

(require 'yasnippet)

(setq yas-snippet-dirs
      (append yas-snippet-dirs
              (list "~/.emacs.d/snippets"
                    (concat skj-project-root "/snippets"))))

(message (concat skj-project-root "/snippets"))

(yas-global-mode 1)

(add-hook 'prog-mode-hook #'yas-minor-mode)


(provide 'skj-prog-snippet)
