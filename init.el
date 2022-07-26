;;; -------------------------------------------------------------------------
;;; Personal init file.
;;; -------------------------------------------------------------------------

;; --------------------------------------------------------------------------
;; Initialize customization

(defgroup skj nil
  "Simon's personal environment settings."
  :tag "skj"
  :prefix "skj-")

(defcustom
  skj-trace-init
  nil
  "Emit tracing messages during initialization, useful with --debug-init."
  :tag "Trace initialization process"
  :group 'skj
  :type 'boolean)

(defcustom
  skj-primary-email
  "johnstonskj@gmail.com"
  "Primary, non-work, email address."
  :tag "Primary email address"
  :group 'skj
  :type 'string)

(defun init-message (message &optional module)
  (unless (eq skj-trace-init nil)
    (if module
        (message "Init [%s] %s" module message)
      (message "Init %s" message))))

(defun concat-path (base-dir path)
  "Concatenate path components, returning an expanded path.

Note that if BASE-DIR is not absolute, or expands to an absolute
path, the result is relative to the current buffer path."
  (expand-file-name (concat (file-name-as-directory base-dir) path)))

;; --------------------------------------------------------------------------
(init-message "Configure execution path")

;; (defun shell-path->list (&optional varname)
;;   (split-string (delete-dups (getenv (if varname varname "PATH")) ":")))

(defun exec-path-prepend (path)
  "Add PATH to the beginning of the current `exec-path` variable
and the shell's `$PATH` variable."
  (unless (member path exec-path)
    (setq exec-path (cons path exec-path))
    (setenv "PATH" (concat path ":" (getenv "PATH")))))

(defun exec-path-append (path)
  "Add PATH to the end of the current `exec-path` variable and
the shell's `$PATH` variable."
  (unless (member path exec-path)
    (setq exec-path (append exec-path (list path)))
    (setenv "PATH" (concat (getenv "PATH") ":" path))))

(init-message (format "exec-path: %s" exec-path))

;; --------------------------------------------------------------------------
(init-message "Override default user details")

(setq
 user-login-name "johnstonskj"
 user-full-name "Simon Johnston"
 user-mail-address "johnstonskj@gmail.com"
 user-home-directory (expand-file-name "~"))

;; --------------------------------------------------------------------------
(init-message "Setting customize values")

;; Do not use `init.el` for `custom-*` code - use `custom.el`.
(setq custom-file (concat-path user-emacs-directory "custom.el"))

;; Assuming that the code in custom-file is execute before the code
;; ahead of this line is not a safe assumption. So load this file
;; proactively.
(load-file (concat-path user-emacs-directory "custom.el"))

;; --------------------------------------------------------------------------
;; Initialize Packages

(init-message "Setting load path")
(add-to-list 'load-path (concat-path user-emacs-directory "lib"))
(add-to-list 'load-path (concat-path user-emacs-directory "lib/skj"))

(require 'skj-packages)

;; --------------------------------------------------------------------------
;; Generic Executable Paths

(when (display-graphic-p)
  (exec-path-prepend "usr/local/bin"))

;; --------------------------------------------------------------------------
;; Generic Configuration

(require 'skj-location)

(require 'skj-ui)

(require 'skj-dashboard)

(require 'skj-org)

(require 'skj-shell)

(require 'skj-writing)

;; --------------------------------------------------------------------------
;; Developer Configuration

(require 'skj-prog-ui)

(require 'skj-prog-github)

(require 'skj-prog-lsp)

(require 'skj-prog-project)

(require 'skj-prog-snippet)

(require 'skj-prog-rust)

(require 'skj-prog-rest)

(require 'skj-prog-services)

;; --------------------------------------------------------------------------
;; One last thing, ...
(init-message "Checking for server")

(require 'server)
(unless (and (fboundp 'server-running)
             (server-running-p))
  (server-start))
