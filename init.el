;;; init.el --- Emacs configuration -*- lexical-binding: t; -*-

;;; Code:

;; --------------------------------------------------------------------------
;; Initialize customization

(defgroup skj nil
  "Simon's personal environment settings."
  :tag "skj"
  :prefix "skj-")

(defcustom
  skj-trace-init
  (if (and (boundp debug-on-error) debug-on-error)
      debug-on-error
    nil)
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

(defcustom
  skj-full-name
  "Simon Johnston"
  "Name to go with email-address."
  :tag "Primary email address"
  :group 'skj
  :type 'string)

(defun init-message (message &optional module)
  "Write MESSAGE to the standard message buffer. The optional MODULE argument
is a symbol that denotes the calling module. This is only enabled if the value
of `skj-trace-init` is non-nil."
  (unless (eq skj-trace-init nil)
    (if module
        (message "Init [%s] %s" module message)
      (message "Init %s" message))))

(defun concat-path (base-dir path)
  "Concatenate PATH components, returning an expanded path.

Note that if BASE-DIR is not absolute, or expands to an absolute
path, the result is relative to the current buffer path."
  (expand-file-name (concat (file-name-as-directory base-dir) path)))

;; --------------------------------------------------------------------------
(init-message "Configure execution path")

;; (defun shell-path->list (&optional varname)
;;   (split-string (delete-dups (getenv (if varname varname "PATH")) ":")))

(defun exec-path-prepend (path)
  "Add PATH to the beginning of the current `exec-path` variable,
and the shell's `$PATH` variable."
  (unless (member path exec-path)
    (setq exec-path (cons path exec-path))
    (setenv "PATH" (concat path ":" (getenv "PATH")))))

(defun exec-path-append (path)
  "Add PATH to the end of the current `exec-path` variable, and
the shell's `$PATH` variable."
  (unless (member path exec-path)
    (setq exec-path (append exec-path (list path)))
    (setenv "PATH" (concat (getenv "PATH") ":" path))))

(when (eq system-type 'darwin)
  (exec-path-prepend "/opt/homebrew/bin"))

(when (display-graphic-p)
  (exec-path-prepend "usr/local/bin"))

(init-message (format "exec-path: %s" exec-path))

;; --------------------------------------------------------------------------
(init-message "Override default user details")

(setq
 user-login-name "johnstonskj" ;; use GitHub ID here
 user-full-name skj-full-name
 user-mail-address skj-primary-email)

(defvar user-home-directory (expand-file-name "~"))

;; --------------------------------------------------------------------------
(init-message "Setting customize values")

;; Do not use `init.el` for `custom-*` code - use `custom.el`.
(defvar emacs-customization-file
  (concat-path user-emacs-directory "custom.el"))

;; Assuming that the code in custom-file is execute before the code
;; ahead of this line is not a safe assumption. So load this file
;; proactively.
(load-file emacs-customization-file)

;; --------------------------------------------------------------------------
;; Initialize Packages

(init-message "Setting load path")
(add-to-list 'load-path (concat-path user-emacs-directory "lib"))
(add-to-list 'load-path (concat-path user-emacs-directory "lib/skj"))

(require 'skj-packages)
(require 'skj-dirs)


;; --------------------------------------------------------------------------
;; Generic Configuration

(require 'skj-ui)
(require 'skj-ui-completion)

(when (eq system-type 'darwin)
  (require 'skj-ui-mac))

(require 'skj-location)

(require 'skj-check)

(require 'skj-shell)

(require 'skj-remote)

(require 'skj-git)
(require 'skj-github)

(require 'skj-org)

(require 'skj-writing)

(require 'skj-snippets) ;; depends on org

;; --------------------------------------------------------------------------
;; Developer Configuration

(require 'skj-prog-ui)

(require 'skj-prog-project)

(require 'skj-prog-dap)
(require 'skj-prog-lsp)
(require 'skj-prog-test)

(require 'skj-prog-data)
(require 'skj-prog-lispy)
(require 'skj-prog-rust)
(require 'skj-prog-web)

(require 'skj-prog-services)

;; --------------------------------------------------------------------------
;; Work Configuration

(require 'skj-work)

;; --------------------------------------------------------------------------
;; One last thing, ...
(init-message "Checking for server")

(require 'server)
(unless (and (fboundp 'server-running) (server-running-p))
  (server-start))

(provide 'init)
;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(sanityinc-solarized-light))
 '(package-selected-packages
   '(lsp-scheme prettify-math prettify-greek fira-code-mode auto-dictionary org-fancy-priorities org-clock-reminder org-gcal org-agenda-property org-analyzer org-beautify-theme org-bullets org-habit-stats org-hyperscheduler org-sync org-tag-beautify smartparens dr-racket-like-unicode flycheck-pest flycheck-projectile geiser-gambit geiser-gauche macrostep-geiser coverage coverlay web-beautify web-mode xref-js2 js2hl js2-refactor js2-highlight-vars js2-mode zmq vterm wakatime-mode emacsql-sqlite-module toml-mode flycheck-yamllint yaml-mode json-mode csv-mode pcsv flycheck-package package-lint scheme-complete quack geiser-racket geiser-chez elisp-slime-nav slime-repl-ansi-color slime-company slime scribble-mode toml pest-mode flycheck-rust rustic rust-playground rust-auto-use cargo-mode tabspaces find-file-in-project project-persist project-explorer projectile-ripgrep projectile-git-autofetch verb dap-mode lsp-ui lsp-mode diff-hl forge magithub magit-todos magit-filenotify magit-lfs bug-reference-github github-review github-pullrequest github-notifier github-explorer github-browse-file git-modes git-timemachine git-link git-blamed git-attr smog bibtex-utils bibretrieve latex-extra latex-math-preview latex-preview-pane focus jinja2-mode easy-jekyll markdown-mode license-snippets gitignore-snippets yasnippet-snippets hl-todo flyspell-correct-ivy ivy-todo ivy-yasnippet ivy-rich ivy-prescient ivy-omni-org ivy-historian ivy-file-preview ivy-explorer ivy-emoji ivy-bibtex smex counsel-web counsel-test counsel-projectile counsel-osx-app counsel-org-capture-string counsel-fd counsel company-web company-quickhelp company-prescient company-org-block company-math company-emoji company-bibtex company mexican-holidays flycheck-plantuml plantuml-mode graphviz-dot-mode ox-wk ox-gfm ob-rust ob-latex-as-png org-timeline org-superstar org-sticky-header org-sidebar org-ref-prettify org-ql org-modern org-doing org-alert osx-trash reveal-in-osx-finder osx-plist osx-org-clock-menubar osx-lib page-break-lines smart-tabs-mode rainbow-delimiters aggressive-indent highlight-indent-guides undo-tree persist everlasting-scratch mc-extras multiple-cursors multicolumn color-theme-sanityinc-solarized ibuffer-sidebar ibuffer-projectile ibuffer-git dired-sidebar dir-treeview buffer-move buffer-expose major-mode-icons mode-icons all-the-icons-dired all-the-icons-completion all-the-icons)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :background "#fdf6e3" :foreground "#657b83" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight light :height 140 :width normal :foundry "nil" :family "Fira Code"))))
 '(focus-unfocused ((t (:inherit font-lock-comment-face :foreground "white"))))
 '(tty-menu-disabled-face ((t (:background "brightgreen" :foreground "lightgray"))))
 '(tty-menu-enabled-face ((t (:background "brightgreen" :foreground "brightwhite" :weight bold))))
 '(tty-menu-selected-face ((t (:background "brightmagenta")))))
