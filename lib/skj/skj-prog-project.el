;;; skj-prog-project.el -*- lexical-binding: t; -*-

(init-message "Setting up project support" 'skj-prog-project)

(require 'skj-prog-ui)

;; --------------------------------------------------------------------------
;; Projectile for project-awareness

(init-message "project support > projectile" 'skj-prog-project)

(require 'projectile)

(setq projectile-completion-system 'ivy
      projectile-require-project-root t
      projectile-project-search-path
      (mapcar (lambda (p)
                (concat (file-name-as-directory skj/project-root-dir) p))
              '("idea" "racket" "rust" "Amazon")))

;; Recommended keymap prefix on macOS
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)

(projectile-mode +1)

;; --------------------------------------------------------------------------
;; Project Explorer for sidebar

(init-message "project support > projectileproject explorer" 'skj-prog-project)

(require 'project-explorer)

(setq pe/filenotify-enabled t
      pe/inline-folders t
      pe/omit-gitignore t
      pe/side 'left
      pe/width 40)

(global-set-key (kbd "<f8>") 'project-explorer-toggle)

(provide 'skj-prog-project)
