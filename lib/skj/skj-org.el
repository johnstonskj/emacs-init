;;; skj-org.el -*- lexical-binding: t; -*-

(init-message "[skj-org] Entered")

;; --------------------------------------------------------------------------
;; Org mode

(require 'org)

(setq org-todo-keywords
      '(;; General to-do items
        (sequence "TODO(t)" "NEXT(n)" "INPROGRESS(p!)" "WAIT(w@/!)" "|" "DONE(d!)" "CANCELED(c@/!)")
        ;; Work-like task items
        (sequence "BACKLOG(b)" "PLAN(p)" "READY(r)" "ACTIVE(a@/!)" "REVIEW(v)" "WAIT(w@/!)" "HOLD(h)" "|" "DONE(d!)" "CANCELED(k@/!)")
        ;; Meeting tracking
        (sequence "REQUESTED(r)" "MEET(m@/!)" "DEFERRED(f@/!)" "|" "CANCELED(x@/!)")
        ))

(setq org-tag-alist
      '((:startgroup)
        ("business" . ?B) ("technical" . ?T) ("hr" . ?H)
        (:endgroup)
        (:startgroup)
        ("l6" . ?6) ("l7" . ?7) ("l8" . ?8) ("l10" . ?0) ("l11" . ?1)
        (:endgroup)
        (:startgroup)
        ("@home" . ?H) ("@travel" . ?V) ("@work" . ?W) ("@Doctor" . ?D)
        (:endgroup)
        (:startgrouptag)
        ("things")
        (:grouptags)
        ("idea" . ?i) ("call" . ?c) ("note" . ?n)
        (:endgrouptag)
        (:startgrouptag)
        ("home")
        (:grouptags)
        ("fix") ("clean") ("garage") ("yard") ("family") ("friends")
        (:endgrouptag)
        (:startgrouptag)
        ("activities")
        (:grouptags)
        ("diving" . ?d) ("synth" . ?s) ("hacking" . ?h)
        (:endgrouptag)
        (:startgrouptag)
        ("finance")
        (:grouptags)
        ("bank") ("insurance") ("budget") ("pcrg") ("kids") ("property")
        (:endgrouptag)
        (:startgrouptag)
        ("work")
        (:grouptags)
        ("coding" . ?o) ("meeting" . ?m) ("planning" . ?p) ("writing" . ?w)
        (:endgrouptag)))

(setq org-todo-keyword-faces
      '(("NEXT" . (:foreground "green" :weight bold))
        ("PLAN" . (:foreground "green" :weight bold))
        ("INPROGRESS" . (:foreground "blue" :weight bold))
        ("ACTIVE" . (:foreground "blue" :weight bold))))

(setq org-log-into-drawer t)

(setq org-priority-highest 1
      org-priority-lowest 5
      org-priority-default 3)

(setq org-directory (expand-file-name "~/Documents/emacs-org"))
(setq org-default-notes-file (concat org-directory "/notes.org"))

;;This damn thing resets 'org-directory
;;(org-clock-persistence-insinuate)

(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)

(add-hook 'org-mode-hook #'turn-on-font-lock)

;; --------------------------------------------------------------------------
;; Org Agenda

(require 'org-agenda)

(setq org-agenda-files
      (list (concat org-directory "/index.org")
            (concat org-directory "/notes.org")
            (concat org-directory "/gcal.org")
            (concat org-directory "/sandi.org")
            (concat org-directory "/birthdays.org")
            (concat org-directory "/holidays.org")))
(setq org-agenda-hide-tags-regexp ".")
(setq org-agenda-log-mode-items '(closed clock state))

(setq org-clock-persist 'history)


(defun skj/org-skip-subtree-if-priority (priority)
  "Skip an agenda subtree if it has a priority of PRIORITY.

PRIORITY must be an integer 1 <= p <= 5."
  (let ((subtree-end (save-excursion (org-end-of-subtree t)))
        (pri-current (org-get-priority (thing-at-point 'line t))))
    (if (= priority pri-current)
        subtree-end
      nil)))

(defun skj/org-skip-subtree-if-habit ()
  "Skip an agenda entry if it has a STYLE property equal to \"habit\"."
  (let ((subtree-end (save-excursion (org-end-of-subtree t))))
    (if (string= (org-entry-get nil "STYLE") "habit")
        subtree-end
      nil)))

(setq org-agenda-custom-commands
      '(("N" "ALL Notes"
         ((tags "NOTE"
                ((org-agenda-overriding-header "Notes:")
                 (org-tags-match-list-sublevels t)))))
        ("m" "ALL Meetings"
         ((tags "CATEGORY=\"Meetings\""
                ((org-agenda-overriding-header "Recurring meetings:")
                 (org-tags-match-list-sublevels t)))))
        ("c" "Simple agenda view"
         ((tags "PRIORITY=1"
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-overriding-header "High-priority unfinished tasks:")))
          (agenda "")
          (alltodo ""
                   ((org-agenda-skip-function
                     '(or (skj/org-skip-subtree-if-priority 1)
                          (org-agenda-skip-if nil '(scheduled deadline))))))))
        ("d" "Daily agenda and all TODOs"
         ((tags "PRIORITY>1"
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-overriding-header "High-priority unfinished tasks:")))
          (agenda ""
                  ((org-agenda-span 'day)
                   (org-agenda-overriding-header "Today's tasks:")))
          (alltodo ""
                   ((org-agenda-skip-function
                     '(or (skj/org-skip-subtree-if-habit)
                          (skj/org-skip-subtree-if-priority 1)
                          (org-agenda-skip-if nil '(scheduled deadline))))
                    (org-agenda-overriding-header "ALL normal priority tasks:")))))))

;; --------------------------------------------------------------------------
;; Standard Calendars

(customize-set-variable 'holiday-bahai-holidays nil)

(require 'mexican-holidays)
(setq calendar-holidays (append calendar-holidays holiday-mexican-holidays))

;; --------------------------------------------------------------------------
;; Org Babel

;;(org-babel-do-load-languages
;; 'org-babel-load-languages
;; '((plantuml . t))) ; this line activates plantuml

;;(setq org-plantuml-jar-path
;;      (expand-file-name "/usr/local/Cellar/plantuml/1.2022.2_1/libexec/plantuml.jar"))

;; --------------------------------------------------------------------------
;; Company integration

(require 'company-org-block)

(setq company-org-block-edit-style 'auto) ;; 'auto, 'prompt, or 'inline

(add-hook 'org-mode-hook
          (lambda ()
            (add-to-list (make-local-variable 'company-backends)
                         'company-org-block)))

;; --------------------------------------------------------------------------
;; Google Calendar

(require 'file-secrets)

(require 'org-gcal)

(defvar skj-org-gcal-file
  (concat org-directory "/gcal.org")
  "Location of file to sync with Google Calendar")

(setq org-gcal-client-id (read-secret-from-file (expand-file-name "~/.config/google/gcal.id")))
(setq org-gcal-client-secret (read-secret-from-file (expand-file-name "~/.config/google/gcal.secret")))
(setq org-gcal-fetch-file-alist (list (cons "johnstonskj@gmail.com" skj-org-gcal-file)
                                      (cons "sandi.mills@gmail.com" (concat org-directory "/sandi.org"))))
(setq org-gcal-file-alist (list (cons "johnstonskj@gmail.com" skj-org-gcal-file)
                                (cons "sandi.mills@gmail.com" (concat org-directory "/sandi.org"))))
(setq org-gcal-local-timezone "America/Los_Angeles")

(message "execute org-gcal-fetch to fetch new calendar updates")
(message "execute org-gcal-post-at-point to turn a TODO into a calendar entry")

(provide 'skj-org)
