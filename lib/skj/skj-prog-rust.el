;;; skj-prog-rust.el -*- lexical-binding: t; -*-
;;;  See: <https://github.com/rust-lang/rust-mode>

(init-message "[skj-prog-rust] Entered")

(require 'rustic)

(setq
 rustic-format-on-save t
 rustic-babel-format-src-block t
 rustic-babel-auto-wrap-main t
 rustic-lsp-server 'rust-analyzer)

(setq
 lsp-rust-analyzer-server-display-inlay-hints t
 lsp-rust-analyzer-cargo-watch-command "clippy")

(defun rustic-mode-auto-save-hook ()
  "Enable auto-saving in rustic-mode buffers."
  (when buffer-file-name
    (setq-local compilation-ask-about-save nil)))
(add-hook 'rustic-mode-hook 'rustic-mode-auto-save-hook)

(provide 'skj-prog-rust)
