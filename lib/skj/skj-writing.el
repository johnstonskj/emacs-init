;;; skj-writing.el --- Generic writing tools -*- lexical-binding: t; -*-

;;; Code:

(init-message "Setting up writing modes" 'skj-writing)

(setq sentence-end-double-space nil)

(require 'skj-packages)

(skj-package-install 'focus)     ;; distraction-free editing: M-x focus-mode

;; --------------------------------------------------------------------------
;; Emoji support

(when (display-graphic-p)
  (add-to-list 'company-backends 'company-emoji)

  (defun --set-emoji-font (frame)
    "Adjust the font settings of FRAME so Emacs can display emoji properly."
    (if (eq system-type 'darwin)
        ;; For NS/Cocoa
        (set-fontset-font t 'symbol (font-spec :family "Apple Color Emoji") frame 'prepend)
      ;; For Linux
      (set-fontset-font t 'symbol (font-spec :family "Symbola") frame 'prepend)))
  
  ;; For when Emacs is started in GUI mode:
  (--set-emoji-font nil)
  ;; Hook for when a frame is created with emacsclient
  ;; see https://www.gnu.org/software/emacs/manual/html_node/elisp/Creating-Frames.html
  (add-hook 'after-make-frame-functions '--set-emoji-font))

;; --------------------------------------------------------------------------
;; Markdown

(skj-package-install '(markdown-mode markdown-mode+))

(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(autoload 'gfm-mode "markdown-mode"
  "Major mode for editing GitHub Flavored Markdown files" t)
(add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))


;; --------------------------------------------------------------------------
;; Blogging

(skj-package-install '(easy-jekyll jinja2-mode))

;; --------------------------------------------------------------------------
;; LaTeX

(skj-package-install
 '(auctex
   auctex-latexmk
   company-auctex
   latex-math-preview ; M-x latex-math-preview-expression
   latex-pretty-symbols
   latex-preview-pane ; (latex-preview-pane-enable)
   latex-extra
   biblio
   bibretrieve
   bibtex-utils))

(add-hook 'LaTeX-mode-hook #'latex-extra-mode)

(setq latex-run-command "xelatex")

(setq TeX-auto-save t)
(setq TeX-parse-self t)

(latex-preview-pane-enable)

;; --------------------------------------------------------------------------
;; LaTeX math

(require 'company-math)

(setq company-tooltip-align-annotations t)

;; global activation of the unicode symbol completion
(add-to-list 'company-backends 'company-math-symbols-unicode)

;; --------------------------------------------------------------------------
;; Spell & style check

(skj-package-install
 '(auto-dictionary flyspell-correct-ivy))

(require 'auto-dictionary)
(add-hook 'flyspell-mode-hook (lambda () (auto-dictionary-mode 1)))

(require 'flyspell)

(setq flyspell-issue-message-flag nil
      ispell-program-name "aspell")

(let* ((env-language (getenv "LANG"))
       (dictionary (first (split-string env-language "\\."))))
  (init-message (format "flyspell using dictionary %s from $LANG" dictionary) 'skj-writing)
  (setq ispell-extra-args (list (concat "--lang=" dictionary))))

(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)

(skj-package-install 'smog)      ;; check writing style: M-x smog-check-buffer

(require 'smog)

(setq smog-command "style -L en")


;; --------------------------------------------------------------------------
;; Bibliography

(skj-package-install '(company-bibtexivy-bibtex ))

(require 'company-bibtex)

(add-to-list 'company-backends 'company-bibtex)


(provide 'skj-writing)
;;; skj-writing.el ends here
