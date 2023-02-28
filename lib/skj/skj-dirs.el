;;; skj-dirs.el --- Common directories -*- lexical-binding: t; -*-

;;; Commentary:
;;;
;;; Assume the following from Emacs:
;;; * user-emacs-directory
;;;
;;; Assume the following are set by init.el:
;;; * user-home-directory
;;; * emacs-customization-file

;;; Code:

(require 'xdg)

(defcustom
  skj-project-root-dir
  (expand-file-name "~/Projects")
  "Root directory for development projects."
  :tag "Project root directory"
  :group 'skj
  :type 'directory)

(defcustom
  skj-snippet-repo-dir
  (concat-path skj-project-root-dir "emacs-snippets")
  "Snippet repository local path."
  :tag "Snippet repository local path"
  :group 'skj
  :type 'directory)

(let ((org-dir (concat-path skj-project-root-dir "emacs-org")))
  (if (boundp 'org-directory)
      (setq org-directory org-dir)
    (defvar org-directory org-dir)))

(provide 'skj-dirs)
;;; skj-dirs.el ends here
