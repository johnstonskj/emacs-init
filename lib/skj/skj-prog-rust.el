;;; skj-prog-rust.el --- Rust language support -*- lexical-binding: t; -*-
;;;
;;; Commentary:
;;;   See: <https://github.com/rust-lang/rust-mode>

;;; Code:

(init-message "Setting up Rust mode(s)" 'skj-prog-rust)

(require 'skj-packages)

(skj-package-install
 '(cargo-mode
   rust-auto-use
   rust-playground
   rustic

   ob-rust))

;; --------------------------------------------------------------------------
;; Generic customization

(require 'rustic)

(setq
 rustic-format-on-save t
 rustic-babel-format-src-block t
 rustic-babel-auto-wrap-main t
 rustic-lsp-server 'rust-analyzer)

(setq
 lsp-rust-analyzer-cargo-load-out-dirs-from-check t
 lsp-rust-analyzer-cargo-watch-enable t
 lsp-rust-analyzer-cargo-watch-command "clippy"
 lsp-rust-analyzer-display-chaining-hints t
 lsp-rust-analyzer-display-closure-return-type-hints t
 lsp-rust-analyzer-display-lifetime-elision-hints-use-parameter-names nil
 lsp-rust-analyzer-display-parameter-hints t
 lsp-rust-analyzer-display-reborrow-hints t
 lsp-rust-analyzer-inlay-hints-mode t
 lsp-rust-analyzer-proc-macro-enable t
 lsp-rust-analyzer-server-display-inlay-hints t)

;; --------------------------------------------------------------------------
;; Basic hooks

(defun rustic-mode-auto-save-hook ()
  "Enable auto-saving in rustic-mode buffers."
  (when buffer-file-name
    (setq-local compilation-ask-about-save nil)))

(add-hook 'rustic-mode-hook 'rustic-mode-auto-save-hook)

;; --------------------------------------------------------------------------
;; LSP Integration

(require 'lsp-lens)

(add-hook 'rustic-mode-hook 'lsp-lens-mode)

;; --------------------------------------------------------------------------
;; Flycheck!

(skj-package-install 'flycheck-rust)

(require 'flycheck)

(setq flycheck-rustic-clippy-executable "cargo-clippy")

(unless (member 'rustic-clippy flycheck-checkers)
  (setq flycheck-checkers (cons 'rustic-clippy flycheck-checkers)))

;; --------------------------------------------------------------------------
;; PEST

(skj-package-install
 '(flycheck-pest pest-mode))

;; --------------------------------------------------------------------------
;; TOML

(skj-package-install 'toml)

(provide 'skj-prog-rust)
;;; skj-prog-rust.el ends here
