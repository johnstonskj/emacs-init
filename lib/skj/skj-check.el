;;; skj-check.el --- Setup Flycheck and friends -*- lexical-binding: t; -*-

;;; Code:

(init-message "Setting up checkers" 'skj-check)


;; --------------------------------------------------------------------------
;; Flycheck

(skj-package-install 'flycheck)

(require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)

(provide 'skj-check)

;;; skj-check.el ends here
