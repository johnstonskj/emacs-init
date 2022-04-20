;;; skj-prog-elisp.el -*- lexical-binding: t; -*-

(init-message "Setting up Emacs Lisp mode" 'skj-prog-elisp)

(require 'checkdoc)
(add-hook 'emacs-lisp-mode-hook 'checkdoc-minor-mode)

(provide 'skj-prog-elisp)
