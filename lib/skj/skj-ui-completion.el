;;; skj-ui-completion.el --- Completion tools (generic) -*- lexical-binding: t; -*-

;;; Code:

(init-message "Setting up Completion" 'skj-ui-completion)

;; --------------------------------------------------------------------------
;; Completion - Company

(init-message "completion > company" 'skj-ui-completion)

(require 'skj-packages)

(skj-package-install
 '(company
   company-emoji
   company-math
   company-prescient
   company-quickhelp
   company-web))

(require 'company)

(setq company-files-exclusions '(".DS_Store")
      company-tooltip-align-annotations t)

(add-hook 'after-init-hook 'global-company-mode)

;; --------------------------------------------------------------------------
;; Completion - Ivy

(init-message "completion > ivy" 'skj-ui-completion)

(skj-package-install
 '(all-the-icons-ivy-rich-mode
   ivy-action
   ivy-emoji
   ivy-explorer
   ivy-file-preview
   ivy-historian
   ivy-prescient
   ivy-rich))

(require 'ivy)

(setq ivy-use-virtual-buffers t
      enable-recursive-minibuffers t
      ivy-count-format "(%d/%d) ")

(ivy-mode 1)

(require 'ivy-explorer)

(ivy-explorer-mode 1)

;; TODO: Look into a failure in ivy-rich-mode
;; Debugger entered--Lisp error: (void-variable ivy--display-transformers-list)

;; (require 'ivy-rich)
;; 
;; (setcdr (assq t ivy-format-functions-alist) #'ivy-format-function-line)
;; 
;; (ivy-rich-mode 1)
;; 
;; (all-the-icons-ivy-rich-mode 1)

;; --------------------------------------------------------------------------
;; Completion - Counsel

(init-message "completion > counsel" 'skj-ui-completion)

(skj-package-install
 '(counsel
   counsel-fd
   counsel-osx-app
   counsel-tramp
   counsel-web))

(require 'counsel)

(setq counsel-find-file-ignore-regexp "\\(?:\\`\\|[/\\]\\)\\(?:[#.]\\)")

(counsel-mode 1)

;; Ivy-based interface to standard commands
(global-set-key (kbd "C-s") 'swiper-isearch)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "M-y") 'counsel-yank-pop)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "<f2> j") 'counsel-set-variable)
(global-set-key (kbd "C-x b") 'ivy-switch-buffer)
(global-set-key (kbd "C-c v") 'ivy-push-view)
(global-set-key (kbd "C-c V") 'ivy-pop-view)

;; Ivy-based interface to shell and system tools
(global-set-key (kbd "C-c c") 'counsel-compile)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c L") 'counsel-git-log)
(global-set-key (kbd "C-c k") 'counsel-rg)
(global-set-key (kbd "C-c m") 'counsel-linux-app)
(global-set-key (kbd "C-c n") 'counsel-fzf)
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-c J") 'counsel-file-jump)
(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
(global-set-key (kbd "C-c w") 'counsel-wmctrl)

;; Ivy-resume (resumes the last Ivy-based completion) and other commands
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "C-c b") 'counsel-bookmark)
(global-set-key (kbd "C-c d") 'counsel-descbinds)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c o") 'counsel-outline)
(global-set-key (kbd "C-c t") 'counsel-load-theme)
(global-set-key (kbd "C-c F") 'counsel-org-file)


(provide 'skj-ui-completion)
;;; skj-ui-completion.el ends here
