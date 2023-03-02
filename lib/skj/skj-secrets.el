;;; skj-secrets.el --- Another secrets manager -*- lexical-binding: t; -*-

;;; Code:

(require 'epg-config)

(setq
 epg-gpg-program "gpg2"
 epg-gpg-home-directory (expand-file-name "~/.gnupg"))

(message (format "[skj-secrets] Using command: %s, as %s" epg-gpg-program (executable-find epg-gpg-program)))

;; --------------------------------------------------------------------------

(require 'xdg)

(defcustom
  skj/secrets-file
  (concat-path (xdg-config-home) "emacs/secrets.el.gpg")
  "This is a GPG-encrypted Emacs Lisp file that will be loaded to allow the
addition of secret values securely. If set to nil no attempt to load any
external secrets will be attempted.

The contents of this file can retrieve secrets from other applications or
simply store them in source and use the function ‘skj/secrets-add’ to add
them to the secret store. The referenced file should have the extension
'.el.gpg' to enable auto decryption on load."
  :tag "External, secure, secrets file"
  :group 'skj
  :type '(file :must-match t))

;; --------------------------------------------------------------------------
(defvar
  skj/secrets--alist
  '()
  "The internal secret store, it is implemented as an association list.

The ‘car’ of each pair is expected to be a symbol, the ‘cdr’ is any
value. The structure of this value can be validated by the function
‘skj/secrets--validate’ and a value can be retrieved using the
function ‘skj/secrets-value’. It is recommended to use the function
‘skj/secrets-add’ to add a new key and secret.")


;; --------------------------------------------------------------------------
(require 'seq)

(defun skj/secrets--validate ()
  "Return t if the value of the variable ‘skj/secrets-alist’ is
correct, or signal an error."
  (if (proper-list-p skj/secrets--alist)
      (seq-every-p
       (lambda (pair)
         (cond
          ((not (consp pair))
           (error "Error [skj-secrets] pair (%s) is not a cons cell" pair))
          ((not (symbolp (car pair)))
           (error "Error [skj-secrets] pair's car (%s) is not a symbol" (car pair)))
          (t)))
       skj/secrets--alist)
    (error "Error [skj-secrets] the secrets list is not a proper list")))


;; --------------------------------------------------------------------------
(defun skj/secrets-add (key secret)
  "Associate the SECRET value with the provided symbol KEY.

This function returns t if the value is added successful, else nil."
  (skj/secrets--validate)
  (cond
   ((not (symbolp key))
    (message "[skj-secrets] Warning key (%s) is not a symbol" key)
    nil)
   ((not (eq (assoc key skj/secrets--alist) nil))
    (message "[skj-secrets] Warning key (%s) already exists as a secret key" key)
    nil)
   (t
    (progn
        (add-to-list 'skj/secrets--alist (cons key secret))
        t))))


;; --------------------------------------------------------------------------
(defun skj/secrets-value (key &optional default)
  "Return the secret value associated with the symbol KEY, or the
value DEFAULT."
  (interactive "SKey: ")
  (skj/secrets--validate)
  (let ((value (alist-get key skj/secrets--alist default)))
    (when (called-interactively-p 'any)
      (message "Secret %s: %s" key value))
    value))


;; --------------------------------------------------------------------------
;; --------------------------------------------------------------------------
(unless (not skj/secrets-file)
  ;; Load the encrypted data using GPG integration.
  (message "[skj-secrets] Loading external secrets (secure) file")
  ;; TODO: test whether this file exists, OR create?
  (load-file skj/secrets-file))


(provide 'skj-secrets)
;;; skj-secrets.el ends here
