;;; skj-prog-lispy.el --- Lisp-like language support -*- lexical-binding: t; -*-

;;; Code:

(init-message "Setting up Lispy modes" 'skj-prog-elisp)

;; --------------------------------------------------------------------------
;; Emacs Lisp

(init-message "Lisp > Emacs lisp" 'skj-prog-elisp)

(require 'skj-packages)

(skj-package-install
 '(package-lint
   flycheck-package))

(require 'checkdoc)
(add-hook 'emacs-lisp-mode-hook 'checkdoc-minor-mode)


;; --------------------------------------------------------------------------
;; Common Lisp

(init-message "Lisp > common lisp" 'skj-prog-elisp)

(skj-package-install
 '(slime
   slime-company
   slime-repl-ansi-color
   elisp-slime-nav))

(setq inferior-lisp-program "/opt/homebrew/bin/sbcl")


;; --------------------------------------------------------------------------
;; Scheme

(init-message "Lisp > scheme" 'skj-prog-elisp)

(skj-package-install
 '(geiser
   geiser-chez
   geiser-gauche
   geiser-racket
   geiser-repl
   macrostep-geiser
   lsp-scheme
   quack
   scheme-complete))

(require 'geiser-mode)
(add-hook 'geiser-mode-hook #'macrostep-geiser-setup)

(require 'geiser-repl)
(add-hook 'geiser-repl-mode-hook #'macrostep-geiser-setup)

(require 'lsp-scheme)
(add-hook 'scheme-mode-hook #'lsp-gambit-scheme)

;; --------------------------------------------------------------------------
;; Racket

(init-message "Lisp > racket" 'skj-prog-elisp)

(skj-package-install
 '(dr-racket-like-unicode
   racket-mode
   scribble-mode))

(provide 'skj-prog-lispy)
;;; skj-prog-lispy.el ends here
