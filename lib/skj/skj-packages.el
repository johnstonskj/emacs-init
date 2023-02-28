;;; skj-packages.el --- Package Operations -*- lexical-binding: t; -*-

;;; Code:

;; --------------------------------------------------------------------------
;; Package Repository Configuration

(init-message "Loading expected packages" 'skj-packages)

(require 'package)

(add-to-list
 'package-archives
 '("melpa" . "http://melpa.org/packages/") t)

(add-to-list
 'package-archives
 '("melpa-stable" . "https://stable.melpa.org/packages/") t)

(setq package-archive-priorities '(("gnu" . 30)
                                   ("nongnu" . 25)
                                   ("melpa-stable" . 20)
                                   ("melpa" . 10)))

(package-initialize)

;; refresh package list if it is not already available
(when (not package-archive-contents)
  (init-message "Refreshing package list" 'skj-packages)
  (package-refresh-contents))

(defun skj-package-install (package)
  "Install a single, or list of, PACKAGE."
  (cond
   ((listp package)
    (dolist (pkg package)
      (skj-package-install pkg)))
   ((symbolp package)
    (init-message (format "Checking for package %s" package) 'skj-packages)
    (when (and (not (package-installed-p package))
               (assoc package package-archive-contents))
      (package-install package)))
   (t
    (error "Expecting a package, or list of packages to install, not %s" package))))

(provide 'skj-packages)
;;; skj-packages.el ends here
