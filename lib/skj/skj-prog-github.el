;;; skj-prog-github.el --- Github integration -*- lexical-binding: t; -*-

;;; Code:

(init-message "Setting up GitHub integrations" 'skj-prog-github)

(require 'skj-packages)

(skj-package-install
 '(github
   github-browse-file
   github-explorer ; M-x github-explorer "txgvnn/github-explorer"
   github-notifier
   github-pullrequest
   github-review
   bug-reference-github

   forge))

;; --------------------------------------------------------------------------
;; Notifications

;; (require 'skj-secrets)
;; 
;; (setq github-notifier-token (skj-secrets-value 'github-token))
;; 
;; (add-hook 'prog-mode-hook #'github-notifier-mode)

(provide 'skj-prog-github)
;;; skj-prog-github.el ends here
