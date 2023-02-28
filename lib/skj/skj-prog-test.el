;;; skj-prog-test.el --- Testing tools -*- lexical-binding: t; -*-

;;; Code:

(init-message "Setting up Testing Tools" 'skj-prog-test)

;; --------------------------------------------------------------------------
;; Test Runners

(require 'skj-packages)

(skj-package-install '(counsel-test))


;; --------------------------------------------------------------------------
;; Coverage

(skj-package-install '(coverlay))


(provide 'skj-prog-test)
;;; skj-prog-test.el ends here
