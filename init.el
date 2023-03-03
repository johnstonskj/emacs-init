;;; init.el --- Emacs configuration Bootstrap -*- lexical-binding: t; -*-

;;; Commentary:
;;;
;;; Bootstrap the rest of the initialization as org files.

;;; Code:

(defun concat-path (base-dir path)
  "Concatenate the BASE-DIR and PATH components, returning an expanded path.
Note that if BASE-DIR is not absolute, or expands to an absolute
path, the result is relative to the current buffer path."
  (expand-file-name (concat (file-name-as-directory base-dir) path)))


(defvar skj/org-init
  (concat-path user-emacs-directory "org-init")
  "The location of the org-files used for initialization.")

;; --------------------------------------------------------------------------

(org-babel-load-file (concat-path skj/org-init "init.org"))

(provide 'init)

;;; init.el ends here
