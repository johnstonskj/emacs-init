;;; skj-shell.el --- Terminals and shells -*- lexical-binding: t; -*-

;;; Code:

(init-message "Setting up shell mode(s)" 'skj-shell)

;; --------------------------------------------------------------------------
;; Internal terminal

(require 'skj-packages)

(skj-package-install 'vterm)

;; --------------------------------------------------------------------------
;; Shell editing

(add-to-list 'auto-mode-alist '("\\.zsh\\'" . sh-mode))

(add-hook 'sh-mode-hook
          (lambda ()
            (if (string-match "\\.zsh$" buffer-file-name)
                (sh-set-shell "zsh"))))

(provide 'skj-shell)
;;; skj-shell.el ends here
