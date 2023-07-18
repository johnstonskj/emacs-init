;;; init-tools.el --- Tools for init.el -*- lexical-binding: t; -*-

;; Author: Simon Johnston <johnstonskj@gmail.com>
;; Version: 0.0.1

;;; License:

;; Copyright (c) 2023 Simon Johnston

;; Permission is hereby granted, free of charge, to any person obtaining a copy
;; of this software and associated documentation files (the "Software"), to deal
;; in the Software without restriction, including without limitation the rights
;; to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
;; copies of the Software, and to permit persons to whom the Software is
;; furnished to do so, subject to the following conditions:

;; The above copyright notice and this permission notice shall be included in all
;; copies or substantial portions of the Software.

;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
;; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
;; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
;; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
;; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
;; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
;; SOFTWARE.

;;; Commentary:

;; Complete description goes here.

;;; Code:

;; --------------------------------------------------------------------------
;; Debugging
;; --------------------------------------------------------------------------

(defvar init/debug (and (boundp debug-on-error) debug-on-error)
  "Do I want to debug the init process?")

(defvar init/message-prefix "INIT: ")

(defun init/message (msg &rest args)
  "A wrapper around `message' to identify init file messages.
This function only emits messages if `init/debug' is non-nil. The meaning of
MSG and ARGS are the sae as for `message'. Each message will be prefixed with
the string in `init/message-prefix'."
  (when init/debug
    (message (concat init/message-prefix msg) args)))

(defun init/add-startup-statistics ()
  "Install a `emacs-startup-hook' to display startup statistics."
  (add-hook 'emacs-startup-hook
            (lambda ()
              (message "Emacs ready in %s with %d garbage collections."
                       (format "%.2f seconds"
                               (float-time
                                (time-subtract after-init-time
                                               before-init-time)))
                       gcs-done))))

(defun init/set-gc-high ()
  "Set the garbage collector to high values during initialization."
  (init/message "gc pc: %s th: %s" gc-cons-percentage gc-cons-threshold)
  (setq gc-cons-percentage 0.6
        gc-cons-threshold most-positive-fixnum))

(defun init/set-gc-normal ()
  "Set the garbage collector to normal operating values."
  (setq gc-cons-percentage 0.1
        gc-cons-threshold (* 2 1024 1024)))

  ;; --------------------------------------------------------------------------
  ;; Paths and Environment
  ;; --------------------------------------------------------------------------

  (defun init/add-to-exec-path (path &optional append)
    "Add PATH to both the `exec-path` variable, and the `$PATH` env variable.
If APPEND is nil the value is put at the beginning of the paths, if
non-nil the value will be put at the end."
    (add-to-list 'exec-path path append)
    (let ((path-env (split-string (getenv "PATH") ":")))
      (when (not (member path path-env))
        (if append
            (setenv "PATH" (concat path-env ":" path))
          (setenv "PATH" (concat path ":" path-env))))))

;; --------------------------------------------------------------------------
;; External Tools
;; --------------------------------------------------------------------------

(defun init/extern-tool-required (command installer &optional advice)
  "Called to determine if the executable COMMAND exists, and if not the
user is asked whether to execute INSTALLER.

The value of ADVICE is used in logging to show where the command was
required."
  (interactive)
  (unless (executable-find command)
    (init/message "WARN: Required command =%s= not found." command)
    (if (yes-or-no-p (format "Run '%s'? " installer))
        (progn
          (message "Running installer...")
          (shell-command installer))
      (init/message "INFO: Need to install command `%s' via =%s=%s."
                    command
                    installer
                    (if advice (format "; %s" advice) "")))))

;; --------------------------------------------------------------------------
;; Grouping Features
;; --------------------------------------------------------------------------

(require 'subr-x) ;; builtin convenience functions.

(defvar init/feature--not-required
  '("dev/aws"
    "dev/lang/ada"
    "dev/lang/cl"
    "dev/lang/dart"
    "dev/lang/ocaml"
    "dev/lang/rdf"
    "dev/lang/provers"))

(defun init/setup-features (&optional not-required env-var)
  (dolist (p (split-string (or (getenv "EMACS_LOCAL_FEATURES_OFF") "") ":"))
    (when (and (stringp p) (> (length p) 0))
      (add-to-list 'init/feature--not-required p))))

(init-message "not-required = %s" init/feature--not-required)

(defvar init/feature--stack '())

(defun init-message (&optional msg &rest args)
  (when init/debug-init
	(let* ((init-prefix "INIT: ")
	       (feature-prefix (string-join (reverse (mapcar 'cadr init/feature--stack)) " > "))
	       (has-feature-prefix (> (length feature-prefix) 0))
	       (msg (concat init-prefix
			            feature-prefix
			            (cond
			             ((and has-feature-prefix msg) (concat " :: " msg))
			             ((and (not has-feature-prefix) msg) msg)
			             ((and has-feature-prefix (not msg)) "...")))))
	  (message msg args))))

(defun init/feature--required (name)
  (let* ((path-parts (reverse (cons name (mapcar (lambda (elt) (car elt)) init/feature--stack))))
	     (path (string-join path-parts "/")))
	(not (seq-some (lambda (p) (or (string= path p)
				              (string-prefix-p (concat p "/") path)))
		           init/feature--not-required))))

(defun init/feature-start (name &optional message)
  "Start a new feature named NAME, with the display MESSAGE.
    If MESSAGE is not specified it will be a capitalized form of the NAME."
  (let* ((name (format "%s" name))
	     (message (if message
		              message
	                (capitalize (string-replace "-" " " name))))
	     (required (init/feature--required name)))
    (setq init/feature--stack
	      (cons (list name message required) init/feature--stack))
    (when (and (init/current-feature-required-p) init/debug-init)
      (init-message))
    (init/current-feature-required-p)))

(defun init/feature-end (&optional name)
  "End the current feature.
The optional NAME is a useful check that you aren't closing out-of-order."
  (when (null init/feature--stack)
    (error "Cannot end feature %s, stack is empty" name))
  (when (and name (not (string= name (caar init/feature--stack))))
    (error "Trying to end feature named %s, current is %s"
	       name (car init/feature--stack)))
  (setq init/feature--stack (cdr init/feature--stack)))

(defsubst init/current-feature-required-p ()
  "Is the current feature required."
  (caddr (car init/feature--stack)))

(provide 'init-tools)

;;; init-tools.el ends here
