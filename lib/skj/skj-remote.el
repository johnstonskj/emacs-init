;;; skj-remote.el --- Remote editing config -*- lexical-binding: t; -*-

;;; Code:

(init-message "Setting up TRAMP" 'skj-remote)

;; --------------------------------------------------------------------------
;; Some Stuff

(require 'skj-packages)

(skj-package-install
 '(counsel-tramp
   docker-tramp))

(use-package tramp
             :config (setq tramp-default-method "ssh"))

(provide 'skj-remote)
;;; skj-remote.el ends here
