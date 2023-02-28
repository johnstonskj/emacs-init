;;; skj-git.el --- Git integration -*- lexical-binding: t; -*-

;;; Code:

(init-message "Setting up Git" 'skj-git)

(require 'skj-packages)

(skj-package-install
 '(git-attr
   git-blamed
   git-link
   git-timemachine
   git-modes

   magit
   magit-diff-flycheck
   magit-lfs
   magit-filenotify
   magit-todos
   magithub

   code-review
   diff-hl))


;; --------------------------------------------------------------------------
;; ibuffer

(skj-package-install '(ibuffer-git))

;; --------------------------------------------------------------------------
;; Magit

(require 'magit)

(magithub-feature-autoinject t)

(setq magit-completing-read-function 'ivy-completing-read)


;; --------------------------------------------------------------------------
;; Add Diff highlighting

(require 'diff-hl)

(add-hook 'magit-pre-refresh-hook 'diff-hl-magit-pre-refresh)
(add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)

(global-diff-hl-mode)


(provide 'skj-git)
;;; skj-prog-git.el ends here
