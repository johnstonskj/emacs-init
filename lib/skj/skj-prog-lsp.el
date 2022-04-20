;;; skj-prog-lsp.el -*- lexical-binding: t; -*-

(init-message "Setting up LSP integration" 'skj-prog-lsp)

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
  "Toggles an imenu list popup. It uses lsp-ui if it is enabled."
  (interactive)
  (if (bound-and-true-p lsp-mode)
      (lsp-ui-imenu)
    (imenu-list-smart-toggle)))

(provide 'skj-prog-lsp)
