;;; skj-org.el -*- lexical-binding: t; -*-

;; See http://doc.norang.ca/org-mode.html

(init-message "Setting up org mode" 'skj-org)

(require 'xdg)

(setq org-directory
      (concat-path "~/Projects" "emacs-org"))

(setq org-default-notes-file (concat-path org-directory "inbox.org"))

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

(setq-default org-enforce-todo-dependencies t)

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

;; Define the custum capture templates
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline org-default-notes-file "Inbox")
	     "* TODO %?\n%u\n%a\n" :clock-in t :clock-resume t)
	    ("m" "Meeting" entry (file+headline org-default-notes-file "Inbox")
	     "* MEETING with %? :MEETING:\n%t" :clock-in t :clock-resume t)
	    ("i" "Idea" entry (file+headline org-default-notes-file "Inbox")
	     "* %? :IDEA: \n%t" :clock-in t :clock-resume t)
	    ("n" "Next Task" entry (file+headline org-default-notes-file "Inbox")
	     "** NEXT %? \nDEADLINE: %t")))

(setq org-log-into-drawer t)

(setq org-priority-highest 1
      org-priority-lowest 5
      org-priority-default 3)

(setq org-refile-targets (quote ((nil :maxlevel . 9)
                                 (org-agenda-files :maxlevel . 9))))

(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)

(setq org-todo-keyword-faces
      '(("NEXT" . (:foreground "green" :weight bold))
        ("PLAN" . (:foreground "green" :weight bold))
        ("INPROGRESS" . (:foreground "blue" :weight bold))
        ("ACTIVE" . (:foreground "blue" :weight bold))))

(add-hook 'org-mode-hook #'turn-on-font-lock)

;; --------------------------------------------------------------------------
;; Org Agenda

(init-message "org mode > agenda" 'skj-org)

(require 'org-agenda)

(setq org-agenda-files
      (list (concat org-directory "/inbox.org")
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
(setq calendar-holidays
      (append calendar-holidays holiday-mexican-holidays))

;; --------------------------------------------------------------------------
;; Org Babel

(setq org-plantuml-jar-path
      (expand-file-name "/usr/local/Cellar/plantuml/1.2022.6/libexec/plantuml.jar"))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((plantuml . t))) ; this line activates plantuml

(org-babel-do-load-languages
 'org-babel-load-languages
 '((dot . t))) ; this line activates dot

;; --------------------------------------------------------------------------
;; Company integration

(init-message "org mode > company" 'skj-org)

(require 'company-org-block)

(setq company-org-block-edit-style 'auto) ;; 'auto, 'prompt, or 'inline

(add-hook 'org-mode-hook
          (lambda ()
            (add-to-list (make-local-variable 'company-backends)
                         'company-org-block)))

;; --------------------------------------------------------------------------
;; Google Calendar

(init-message "org mode > gcal" 'skj-org)

(require 'org-gcal)

(defcustom skj-org-gcal-file
  (concat org-directory "/gcal.org")
  "Location of `org-mode' file to sync with Google Calendar"
  :tag "Org file for Google Calendar"
  :group 'skj
  :type 'file)

(require 'skj-secrets)

(setq org-gcal-client-id (skj-secrets-value 'gcal-id))
(setq org-gcal-client-secret (skj-secrets-value 'gcal-secret))

(setq org-gcal-fetch-file-alist
      (list (cons skj-primary-email skj-org-gcal-file)
            (cons "sandi.mills@gmail.com" (concat org-directory "/sandi.org"))))

(setq org-gcal-file-alist
      (list (cons skj-primary-email skj-org-gcal-file)
            (cons "sandi.mills@gmail.com" (concat org-directory "/sandi.org"))))

(require 'skj-location)

(setq org-gcal-local-timezone skj-calendar-time-zone-name)

(message "execute org-gcal-fetch to fetch new calendar updates")
(message "execute org-gcal-post-at-point to turn a TODO into a calendar entry")


;; --------------------------------------------------------------------------
;; Appointment integration

(init-message "org mode > appt" 'skj-org)

(require 'appt)

(setq appt-display-format 'window
      appt-display-duration 30
      appt-audible t
      appt-display-mode-line t)

; Activate appointments so we get notifications
(appt-activate t)

; Erase all reminders and rebuilt reminders for today from the agenda
(defun skj/org-agenda-to-appt ()
  (interactive)
  (setq appt-time-msg-list nil)
  (org-agenda-to-appt))

; Rebuild the reminders everytime the agenda is displayed
(add-hook 'org-agenda-finalize-hook 'skj/org-agenda-to-appt 'append)

; If we leave Emacs running overnight - reset the appointments one minute after midnight
(run-at-time "24:01" nil 'skj/org-agenda-to-appt)

; Run now so appointments are set up when Emacs starts
(skj/org-agenda-to-appt)

(provide 'skj-org)
