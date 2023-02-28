;;; skj-github.el --- Github integration -*- lexical-binding: t; -*-

;;; Code:

(init-message "Setting up GitHub integrations" 'skj-github)

(require 'skj-packages)

(skj-package-install
 '(github
   github-browse-file
   github-explorer ; M-x github-explorer "txgvnn/github-explorer"
   github-pullrequest
   github-review))


;; --------------------------------------------------------------------------
;; Bug References

(add-hook 'prog-mode-hook #'bug-reference-prog-mode)

(skj-package-install 'bug-reference-github)

(require 'bug-reference-github)

(add-hook 'prog-mode-hook 'bug-reference-github-set-url-format)


;; --------------------------------------------------------------------------
;; Notifications

;; (skj-package-install 'github-notifier)
;;
;; (require 'skj-secrets)
;; 
;; (setq github-notifier-token (skj-secrets-value 'github-token))
;; 
;; (add-hook 'prog-mode-hook #'github-notifier-mode)



(provide 'skj-github)
;;; skj-github.el ends here
