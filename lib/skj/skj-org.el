;;; skj-org.el --- ORG mode -*- lexical-binding: t; coding: utf-8; -*-
;;;
;;; Commentary:
;;;   See http://doc.norang.ca/org-mode.html

;;; Code:

(init-message "Setting up org mode" 'skj-org)

(require 'skj-dirs)

(setq org-default-notes-file (concat-path org-directory "inbox.org"))


;; --------------------------------------------------------------------------
;; Org mode

(require 'skj-packages)

(skj-package-install 'org-ql)

(require 'org)

;; Specify (<char>Before/After) where either Before/After may be @ for
;; record time AND comment, ! for just time
(setq org-todo-keywords
      '(;; Simple reminders
        (sequence "NUDGE(g)" "|" "DONE(d!)")
        ;; General to-do items
        (sequence "TODO(t)" "NEXT(n!)" "INPROGRESS(p!)" "WAIT(w@/!)" "|" "DONE(d!)" "CANCELED(c@)")
        ;; Work-like task items
        (sequence "BACKLOG(b)" "PLAN(p!)" "READY(r!)" "ACTIVE(a@/!)" "REVIEW(v)" "WAIT(w@/!)" "HOLD(h)" "|" "DONE(d!)" "CANCELED(c@)")
        ;; Appointment and Meeting tracking
        (sequence "SCHEDULE(s/!)" "REQUESTED(r)" "BOOKED(b@/!)" "DEFERRED(f@/!)" "RESCHEDULE(e@/!)" "|" "DONE(d!)" "CANCELED(c@)")))

(setq-default org-enforce-todo-dependencies t)

(setq org-tag-alist
      '((:startgroup)
        ("@home" . ?H) ("@travel" . ?V) ("@work" . ?W) ("@doctor" . ?D)
        (:endgroup)
        
        (:startgrouptag)
        ("generic")
        (:grouptags)
        ("idea" . ?i) ("call" . ?c) ("errand" . ?e) ("remind" . ?r)
        (:endgrouptag)
        
        (:startgrouptag)
        ("home")
        (:grouptags)
        ("fix") ("clean") ("garage") ("yard") ("family") ("friends")
        ("finance") ("estate") ("pets")
        (:endgrouptag)
        
        (:startgrouptag)
        ("home-fun")
        (:grouptags)
        ("diving" . ?d) ("hacking" . ?h) ("music" . ?m) ("synth" . ?s)
        (:endgrouptag)
        
        (:startgrouptag)
        ("work")
        (:grouptags)
        ("coding" . ?o) ("meeting" . ?m) ("planning" . ?p) ("writing" . ?w)
        ("business" . ?B) ("technical" . ?T) ("hr" . ?H)
        ("l6" . ?6) ("l7" . ?7) ("l8" . ?8) ("l10" . ?0) ("l11" . ?1)
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
	     "** NEXT %? \nDEADLINE: %t")
        ("d" "Distraction" entry (file+headline
                                  (concat org-directory "/distractions.org")
                                  "Distractions")
         "* %?\n%T")))

(setq org-log-into-drawer t)

(setq org-priority-highest ?A
      org-priority-lowest ?E
      org-priority-default ?C)

(setq org-highest-priority ?A
      org-lowest-priority ?E
      org-default-priority ?C)

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

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))


;; --------------------------------------------------------------------------
;; Clock

(skj-package-install 'org-clock-reminder)

(require 'org-clock-reminder)

(org-clock-reminder-mode)

;; ; By default, notifications (active, inactive) are shown every 10 minutes
(setq org-clock-reminder-interval 10)

;; Active notifications are shown every 3 minute, inactive every 3
(setq org-clock-reminder-interval (cons 3 10))

;; --------------------------------------------------------------------------
;; UI

(init-message "org mode > UI" 'skj-org)

(skj-package-install
 '(org-alert
   org-beautify-theme
   org-bullets
   org-fancy-priorities
   org-ivy-search
   org-modern
   org-sidebar
   org-superstar
   org-tag-beautify

   ivy-omni-org
   ivy-todo))

(require 'org-bullets)

(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(require 'org-fancy-priorities)

(setq
 org-fancy-priorities-list
 '((?A . "⚡") (?B . "⬆") (?C . " ") (?D . "⬇") (?E . "☕"))
 org-priority-faces
 '((?A :foreground "red" :weight bold)
   (?B :foreground "orange" :weight semi-bold)
   (?C :foreground "green" :weight normal)
   (?B :foreground "blue" :weight semi-light)
   (?C :foreground "grey" :weight light)))

(add-hook 'org-agenda-mode-hook 'org-fancy-priorities-mode)

;; (require 'org-pretty-tags)
;; 
;; (setq
;;  org-pretty-tags-surrogate-strings
;;  '(("@home" . "🏠")
;;    ("@travel" . "✈️")
;;    ("@work" . "📥")
;;    ("@doctor" . "🩺")
;;    
;;    ("idea" . "💡")
;;    ("call" . "📞")
;;    ("errand" . "🚗")
;;    ("remind" . "🔔")
;;    ("music" . "🎫")
;;    ("diving" . "🤿")
;;    ("synth" . "🎛")
;;    ("hacking" . "💻")
;;    ("garage" . "🧰")
;;    ("pets" . "😸")
;;    ("yard" . "🪴")
;; 
;;    ("finance" . "💰")
;;    ("estate" . "💀")
;; 
;;    ("meeting" . "📅")
;;    ("planning" . "🔮")
;;    ("review" . "👀")
;;    ("writing" . "✏️")))
;; 
;; (org-pretty-tags-global-mode)


;; --------------------------------------------------------------------------
;; Habits

(init-message "org mode > habits" 'skj-org)

(skj-package-install 'org-habit-stats)

(require 'org-habit)
(add-to-list 'org-modules 'org-habit t)

(setq org-habit-show-all-today t
      org-habit-show-habits-only-for-today t
      org-habit-show-done-always-green t
      org-habit-graph-column 60
      org-habit-preceding-days 28
      org-habit-following-days 7)


;; --------------------------------------------------------------------------
;; Org Agenda

(init-message "org mode > agenda" 'skj-org)

(skj-package-install
 '(org-agenda-property
   org-super-agenda
   org-timeline))

(require 'org-agenda)

(setq org-agenda-files
      (list (concat org-directory "/inbox.org")
            (concat org-directory "/notes.org")
            (concat org-directory "/gcal.org")
            (concat org-directory "/birthdays.org")
            (concat org-directory "/holidays.org")))
(setq org-agenda-hide-tags-regexp ".")
(setq org-agenda-log-mode-items '(closed clock state))

(setq org-clock-persist 'history)
(setq org-remember-clock-out-on-exit t)

(add-hook 'org-agenda-finalize-hook 'org-timeline-insert-timeline :append)

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
      '(("m"
         "ALL Meetings"
         ((tags "CATEGORY=\"Meetings\""
                ((org-agenda-overriding-header "Meetings:")
                 (org-tags-match-list-sublevels t)))))
        ("d"
         "Daily agenda review"
         ((tags "PRIORITY=1"
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-overriding-header "High-priority unfinished tasks:")))
          (agenda "")
          (alltodo ""
                   ((org-agenda-skip-function
                     '(or (skj/org-skip-subtree-if-priority 1)
                          (org-agenda-skip-if nil '(scheduled deadline)))))))
         nil
         ("~/daily-agenda.html"))))

(setq org-columns-default-format-for-agenda
      "%35ITEM(Task) %10TODO(State) %3PRIORITY(P) %30ALLTAGS(All Tags) %23SCHEDULED(Scheduled to Start) %22DEADLINE(Deadline) %6EFFORT(Effort){:}")


;; --------------------------------------------------------------------------
;; Standard Calendars

(init-message "org mode > calenders" 'skj-org)

(customize-set-variable 'holiday-bahai-holidays nil)

(skj-package-install 'mexican-holidays)

(require 'mexican-holidays)

(setq calendar-holidays
      (append calendar-holidays holiday-mexican-holidays))


;; --------------------------------------------------------------------------
;; Org Babel

(init-message "org mode > blocks" 'skj-org)

;; Always redisplay images after C-c C-c (org-ctrl-c-ctrl-c)
(add-hook 'org-babel-after-execute-hook 'org-redisplay-inline-images)

(skj-package-install
 '(ob-latex-as-png
   graphviz-dot-mode
   plantuml-mode))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((dot . t))) ; this line activates dot

(setq org-plantuml-jar-path
      (expand-file-name "/usr/local/Cellar/plantuml/1.2022.6/libexec/plantuml.jar"))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((plantuml . t))) ; this line activates plantuml

(skj-package-install 'flycheck-plantuml)

(require 'flycheck-plantuml)

(flycheck-plantuml-setup)


;; --------------------------------------------------------------------------
;; References

(init-message "org mode > references" 'skj-org)

(skj-package-install
 '(org-ref
    org-ref-prettify))

 
;; --------------------------------------------------------------------------
;; Company integration

(init-message "org mode > company" 'skj-org)

(skj-package-install 'company-org-block)

(require 'company-org-block)

(setq company-org-block-edit-style 'auto) ;; 'auto, 'prompt, or 'inline

(add-hook 'org-mode-hook
          (lambda ()
            (add-to-list (make-local-variable 'company-backends)
                         'company-org-block)))


;; --------------------------------------------------------------------------
;; Sync (Google Calendar)

(init-message "org mode > gcal" 'skj-org)

(require 'skj-secrets)

(setq org-gcal-client-id (skj-secrets-value 'gcal-id))
(setq org-gcal-client-secret (skj-secrets-value 'gcal-secret))

(skj-package-install 'org-gcal)

(require 'org-gcal)

(defcustom skj-org-gcal-file
  (concat org-directory "/gcal.org")
  "Location of `org-mode' file to sync with Google Calendar."
  :tag "Org file for Google Calendar"
  :group 'skj
  :type 'file)

(setq org-gcal-fetch-file-alist
      (list (cons skj-primary-email skj-org-gcal-file)))

(setq org-gcal-local-timezone "America/Los_Angeles")

(message "execute org-gcal-fetch to fetch new calendar updates")
(message "execute org-gcal-post-at-point to turn a TODO into a calendar entry")


;; --------------------------------------------------------------------------
;; Sync (Issue Trackers)

(init-message "org mode > issues" 'skj-org)

(skj-package-install 'org-sync)


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

(defun skj-org-agenda-to-appt ()
  "Erase all reminders and rebuilt reminders for today from the agenda."
  (interactive)
  (setq appt-time-msg-list nil)
  (org-agenda-to-appt))

; Rebuild the reminders everytime the agenda is displayed
(add-hook 'org-agenda-finalize-hook 'skj-org-agenda-to-appt 'append)

; If we leave Emacs running overnight - reset the appointments one minute after midnight
(run-at-time "24:01" nil 'skj-org-agenda-to-appt)

; Run now so appointments are set up when Emacs starts
(skj-org-agenda-to-appt)


;; --------------------------------------------------------------------------
;; Export

(init-message "org mode > exports" 'skj-org)

(skj-package-install '(ox-gfm ox-wk))


;; --------------------------------------------------------------------------
;; Key bindings

(global-set-key (kbd "<f5>") 'org-agenda)
(global-set-key (kbd "C-<f5>") 'org-store-agenda-views)

(global-set-key (kbd "<f6> i") 'org-clock-in)
(global-set-key (kbd "<f6> o") 'org-clock-out)
(global-set-key (kbd "<f6> g") 'org-clock-goto)
(global-set-key (kbd "<f6> <f6>") 'org-clock-menu)

(provide 'skj-org)
;;; skj-org.el ends here
