;;; skj-prog-web.el --- Web programming -*- lexical-binding: t; -*-

;;; Code:

(init-message "Setting webdev related stuff" 'skj-prog-web)

(require 'skj-packages)

(skj-package-install
 '(web-mode
   web-beautify

   js2-mode
   js2-highlight-vars
   js2-refactor
   js2hl
   xref-js2))

(add-to-list 'auto-mode-alist '("\\.mjs\\'" . js2-mode))

(provide 'skj-prog-web)
;;; skj-prog-web.el ends here
