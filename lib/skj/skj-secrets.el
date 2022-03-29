;;; skj-secrets.el -*- lexical-binding: t; -*-

(init-message "[skj-secrets] Entered")

;; --------------------------------------------------------------------------
(defvar
  skj-secrets--alist
  '()
  "An internal alist containing secrets. 

The ‘car’ of each pair is expected to be a symbol, the ‘cdr’ is any
value. The structure of this value can be validated by the function
‘skj-secrets--validate’ and a value can be retrieved using the 
function ‘skj-secrets-value’. It is recommended to use the function
‘skj-secrets-add’ to add a new key and secret.")

;; Load the encrypted data using GPG
(load-file (expand-file-name "~/.config/emacs/secrets.el.gpg"))


;; --------------------------------------------------------------------------
(require 'seq)

(defun skj-secrets--validate ()
  "Returns t if the value of the variable ‘skj-secrets-alist’ is 
correct or signal an error."
  (if (proper-list-p skj-secrets--alist)
      (seq-every-p
       (lambda (pair)
         (cond
          ((not (consp pair))
           (error "[skj-secrets] ERR: pair (%s) is not a cons cell" pair))
          ((not (symbolp (car pair)))
           (error "[skj-secrets] ERR: pair's car (%s) is not a symbol" (car pair)))
          (t)))
       skj-secrets--alist)
    (error "[skj-secrets] ERR: the secrets list is not a proper list")))


;; --------------------------------------------------------------------------
(defun skj-secrets-add (key secret)
  "Associate the SECRET value with the provided symbol KEY.

This function returns t if the value it is successful, else nil."
  (skj-secrets--validate)
  (cond
   ((not (symbolp key))
    (message "[skj-secrets] WARN: key (%s) is not a symbol" key)
    nil)
   ((not (eq (assoc key skj-secrets--alist) nil))
    (message "[skj-secrets] WARN: key (%s) already exists as a secret key" key)
    nil)
   (t
    (progn
        (add-to-list 'skj-secrets--alist (cons key secret))
        t))))


;; --------------------------------------------------------------------------
(defun skj-secrets-value (key &optional default)
  "Return the secret value associated with the symbol KEY, or the 
value DEFAULT."
  (interactive "SKey: ")
  (skj-secrets--validate)
  (let ((value (alist-get key skj-secrets--alist default)))
    (when (called-interactively-p 'any)
      (message "%s: %s" key value))
    value))


(provide 'skj-secrets)
;;; skj-secrets.el ends here
