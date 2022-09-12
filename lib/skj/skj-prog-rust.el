;;; skj-prog-rust.el -*- lexical-binding: t; -*-
;;;  See: <https://github.com/rust-lang/rust-mode>

(init-message "Setting up Rust mode(s)" 'skj-prog-rust)

(require 'rustic)

(setq
 rustic-format-on-save t
 rustic-babel-format-src-block t
 rustic-babel-auto-wrap-main t
 rustic-lsp-server 'rust-analyzer)

(setq
 lsp-rust-analyzer-server-display-inlay-hints t
 lsp-rust-analyzer-display-parameter-hints t
 lsp-rust-analyzer-display-chaining-hints t)

(defun rustic-mode-auto-save-hook ()
  "Enable auto-saving in rustic-mode buffers."
  (when buffer-file-name
    (setq-local compilation-ask-about-save nil)))

(add-hook 'rustic-mode-hook 'rustic-mode-auto-save-hook)

;; (setq flycheck-rustic-clippy-executable "cargo-clippy")
;; 
;; (unless (member 'rustic-clippy flycheck-checkers)
;;   (setq flycheck-checkers (cons 'rustic-clippy flycheck-checkers)))

(provide 'skj-prog-rust)
