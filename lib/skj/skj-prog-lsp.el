;;; skj-prog-lsp.el --- LSP generic configuration -*- lexical-binding: t; -*-

;;; Code:

(init-message "Setting up LSP integration" 'skj-prog-lsp)

(require 'skj-packages)

(skj-package-install '(lsp-mode lsp-ui))

;; --------------------------------------------------------------------------
;; Generic dev-tool customization

(require 'lsp)

(setq
 lsp-eldoc-render-all t
 lsp-idle-delay 0.6)

(require 'lsp-ui)

(setq
 lsp-ui-peek-always-show t
 lsp-ui-sideline-show-hover t
 lsp-ui-doc-enable nil)

(add-hook 'lsp-mode-hook 'lsp-ui-mode)

;;;###autoload
(defun skj-imenu-toggle-maybe-lsp ()
  "Toggle an imenu list popup; it will use lsp-ui if it is enabled."
  (interactive)
  (if (bound-and-true-p lsp-mode)
      (lsp-ui-imenu)
    (imenu-list-smart-toggle)))

(provide 'skj-prog-lsp)
;;; skj-prog-lsp.el ends here
