;;; skj-prog-project.el -*- lexical-binding: t; -*-

(init-message "[skj-prog-project] Entered")

(require 'skj-prog-ui)

;; --------------------------------------------------------------------------
;; Projectile for project-awareness

(require 'projectile)
(setq projectile-require-project-root t)
(setq projectile-project-search-path
      (list (concat skj-project-root "/idea")
            (concat skj-project-root "/racket")
            (concat skj-project-root "/rust")
            (concat skj-project-root "/Amazon")))

;; Recommended keymap prefix on macOS
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)

(projectile-mode +1)

;; --------------------------------------------------------------------------
;; Project Explorer for sidebar

(require 'project-explorer)
(setq pe/filenotify-enabled t
      pe/inline-folders t
      pe/omit-gitignore t
      pe/side 'left
      pe/width 40)

(global-set-key (kbd "<f8>") 'project-explorer-toggle)

(provide 'skj-prog-project)
