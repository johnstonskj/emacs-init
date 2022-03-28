;;; skj-prog-rust.el -*- lexical-binding: t; -*-
;;;  See: <https://github.com/rust-lang/rust-mode>

(init-message "[skj-prog-rust] Entered")

(require 'rust-mode)

(autoload 'rust-mode "rust-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))

(define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)

(add-hook 'after-init-hook #'global-flycheck-mode)

(with-eval-after-load 'rust-mode
  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))

(require 'rustic)
(setq
 rustic-format-on-save t
 rustic-babel-format-src-block t
 rustic-babel-auto-wrap-main t)

(setq
 lsp-rust-analyzer-server-display-inlay-hints t
 lsp-rust-analyzer-cargo-watch-command "clippy")

(provide 'skj-prog-rust)
