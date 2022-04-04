;;; skj-prog-elisp.el -*- lexical-binding: t; -*-

(init-message "[skj-prog-elisp] Entered")

(require 'checkdoc)
(add-hook 'emacs-lisp-mode-hook 'checkdoc-minor-mode)

(provide 'skj-prog-elisp)
