;;; skj-prog-ui.el -*- lexical-binding: t; -*-

;;; Code:

(init-message "Setting up common programming UI" 'skj-prog-ui)


;; --------------------------------------------------------------------------
;; Symbols

(skj-package-install
 '(fira-code-mode
   prettify-greek
   prettify-math))

(when (display-graphic-p)
  (add-hook 'prog-mode-hook 'fira-code-mode))

(add-hook 'scheme-mode-hook #'prettify-symbols-mode)

;; Set delimiters before this module loaded
(setq prettify-math-delimiters-alist
      '(("$" tex)
        ("$$" tex block)
        (("\\(" . "\\)") tex block)
        ("`" asciimath)
        ("``" asciimath block)))

(require 'prettify-math)

(require 'prettify-greek)

(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (setq prettify-symbols-alist prettify-greek-lower)
            (prettify-symbols-mode t)))


;; --------------------------------------------------------------------------
;; Delimiters/Parens

(skj-package-install
 '(smartparens
   rainbow-delimiters))

(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)


;; --------------------------------------------------------------------------
;; Indentation

(skj-package-install
 '(aggressive-indent
   highlight-indent-guides
   smart-tabs-mode))

(require 'aggressive-indent)

(add-hook 'emacs-lisp-mode-hook #'aggressive-indent-mode)
(add-hook 'css-mode-hook #'aggressive-indent-mode)

(require 'highlight-indent-guides)

(setq
 highlight-indent-guides-method 'character
 highlight-indent-guides-responsive 'stack)

(set-face-foreground 'highlight-indent-guides-character-face "brightmagenta")

(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)


;; --------------------------------------------------------------------------
;; Company completion

(require 'company)

(setq company-files-exclusions '(".git/" ".DS_Store"))
(setq company-tooltip-align-annotations t)

(add-hook 'web-mode-hook
          (lambda ()
            (set (make-local-variable 'company-backends) '(company-web-html))
            (company-mode t)))


;; --------------------------------------------------------------------------
;; Odds & ends

(skj-package-install
 '(hl-todo))


(provide 'skj-prog-ui)
;;; skj-prog-ui.el ends here
