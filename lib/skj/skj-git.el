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
   magit-org-todos
   magit-todos  

   code-review
   diff-hl))


;; --------------------------------------------------------------------------
;; ibuffer

(skj-package-install '(ibuffer-git))

;; --------------------------------------------------------------------------
;; Magit

(require 'magit)

(setq magit-completing-read-function 'ivy-completing-read)

(require 'magit-org-todos)

;; Add contents of TODO.org file from project root into Magit buffers
(magit-org-todos-autoinsert)

(require 'magit-todos)

;; --------------------------------------------------------------------------
;; Insert Issues as 'Fixes #' in commits

(skj-package-install 'git-commit-insert-issue)

(require 'git-commit-insert-issue)

(add-hook 'git-commit-mode-hook 'git-commit-insert-issue-mode)

;; --------------------------------------------------------------------------
;; Add Diff highlighting

(require 'diff-hl)

(add-hook 'magit-pre-refresh-hook 'diff-hl-magit-pre-refresh)
(add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)

(global-diff-hl-mode)


(provide 'skj-git)
;;; skj-git.el ends here
