;;; skj-dashboard.el -*- lexical-binding: t; -*-

(init-message "[skj-dashboard] Entered")

(require 'dashboard)
(setq dashboard-items '((recents  . 10)
                        (projects . 15)
                        (agenda . 10)
                        (bookmarks . 5)
                        (registers . 5)))
(setq dashboard-projects-switch-function 'projectile-persp-switch-project)
(setq dashboard-set-navigator t)
(setq dashboard-set-init-info nil)
(setq dashboard-set-footer nil)
(setq dashboard-set-heading-icons t)
(setq dashboard-set-file-icons t)
(setq dashboard-week-agenda t)
(setq dashboard-org-agenda-categories '("Tasks" "Appointments"))

(dashboard-setup-startup-hook)

(provide 'skj-dashboard)
