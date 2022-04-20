;;; skj-writing.el -*- lexical-binding: t; -*-

(init-message "Setting up writing modes" 'skj-writing)

(setq sentence-end-double-space nil)

;; --------------------------------------------------------------------------
;; Emoji support

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
(add-hook 'after-make-frame-functions '--set-emoji-font)

;; --------------------------------------------------------------------------
;; Markdown

(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(autoload 'gfm-mode "markdown-mode"
  "Major mode for editing GitHub Flavored Markdown files" t)
(add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))

;; --------------------------------------------------------------------------
;; LaTeX

(add-hook 'LaTeX-mode-hook #'latex-extra-mode)

;; --------------------------------------------------------------------------
;; LaTeX math

(require 'company-math)

(setq company-tooltip-align-annotations t)

;; global activation of the unicode symbol completion 
(add-to-list 'company-backends 'company-math-symbols-unicode)

;; --------------------------------------------------------------------------
;; Bibliography

(require 'company-bibtex)

(add-to-list 'company-backends 'company-bibtex)

;; --------------------------------------------------------------------------
;; Olivetti

(require 'olivetti)
(setq olivetti-body-width 82)

(provide 'skj-writing)
