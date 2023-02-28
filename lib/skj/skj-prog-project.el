;;; skj-prog-project.el --- Project support -*- lexical-binding: t; -*-

;;; Code:

(init-message "Setting up project support" 'skj-prog-project)

(require 'skj-prog-ui)

;; --------------------------------------------------------------------------
;; Projectile for project-awareness

(init-message "project support > projectile" 'skj-prog-project)

(require 'skj-packages)

(skj-package-install
 '(projectile
   projectile-git-autofetch
   projectile-ripgrep

   project-explorer
   project-persist
   find-file-in-project

   counsel-projectile
   flycheck-projectile))

(require 'projectile)

(setq projectile-completion-system 'ivy
      projectile-require-project-root t
      projectile-project-search-path
      (mapcar (lambda (p)
                (concat (file-name-as-directory skj-project-root-dir) p))
              '("emacs-little-packages" "racket" "rust" "Amazon")))

;; Recommended keymap prefix on macOS
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)

(projectile-mode +1)

(init-message "project support > projectile > ibuffer" 'skj-prog-project)

(skj-package-install '(ibuffer-projectile))

(require 'ibuffer-projectile)

(add-hook 'ibuffer-hook
          (lambda ()
            (ibuffer-projectile-set-filter-groups)
            (unless (eq ibuffer-sorting-mode 'alphabetic)
              (ibuffer-do-sort-by-alphabetic))))

;; --------------------------------------------------------------------------
;; Project Explorer for sidebar

(init-message "project support > project explorer" 'skj-prog-project)

(require 'project-explorer)

(setq pe/filenotify-enabled t
      pe/inline-folders t
      pe/omit-gitignore t
      pe/side 'left
      pe/width 40)

(global-set-key (kbd "<f8>") 'project-explorer-toggle)

(provide 'skj-prog-project)
;;; skj-prog-project.el ends here
