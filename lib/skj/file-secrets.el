;;; file-secrets.el -*- lexical-binding: t; -*-

(defun read-secret-from-file (file)
  "File to string function"
  (with-temp-buffer
    (insert-file-contents file)
    (string-trim
     (buffer-string))))

(provide 'file-secrets)
