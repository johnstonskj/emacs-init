;;; skj-shell.el -*- lexical-binding: t; -*-

(init-message "[skj-shell] Entered")

;; --------------------------------------------------------------------------
;; Shell editing

(add-to-list 'auto-mode-alist '("\\.zsh\\'" . sh-mode))

(add-hook 'sh-mode-hook
          (lambda ()
            (if (string-match "\\.zsh$" buffer-file-name)
                (sh-set-shell "zsh"))))

(provide 'skj-shell)
