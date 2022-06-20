;;; skj-prog-lisp.el -*- lexical-binding: t; -*-

(init-message "Setting up Emacs Lisp mode" 'skj-prog-elisp)

(require 'checkdoc)
(add-hook 'emacs-lisp-mode-hook 'checkdoc-minor-mode)

(init-message "Setting up SLIME mode for SBCL" 'skj-prog-elisp)

(load (expand-file-name "~/.quicklisp/slime-helper.el"))
(setq inferior-lisp-program "/usr/local/bin/sbcl")

(provide 'skj-prog-lisp)
