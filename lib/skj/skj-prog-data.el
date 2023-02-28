;;; skj-prog-data.el --- Data Formats -*- lexical-binding: t; -*-

(init-message "Setting up Data Files/Query" 'skj-prog-data)

;; --------------------------------------------------------------------------
;; Data File Formats

(require 'skj-packages)

(skj-package-install
 '(pcsv
   csv-mode
   json-mode
   toml-mode
   yaml-mode
   flycheck-yamllint))


;; --------------------------------------------------------------------------
;; SQL Stuff

(skj-package-install
 '(emacsql
   emacsql-sqlite-module))


(provide 'skj-prog-data)
;;; skj-prog-data.el ends here
