;; --------------------------------------------------------------------------
;; Initialize customization

(init-message "Setting custom variables")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(color-theme-is-global t t)
 '(counsel-find-file-ignore-regexp "\\(?:\\`\\|[/\\]\\)\\(?:[#.]\\)")
 '(custom-enabled-themes '(sanityinc-solarized-light))
 '(custom-safe-themes
   '("4cf3221feff536e2b3385209e9b9dc4c2e0818a69a1cdb4b522756bcdf4e00a4" default))
 '(dir-treeview-show-in-side-window t)
 '(echo-keystrokes 0.5)
 '(fill-column 78)
 '(holiday-bahai-holidays nil)
 '(indent-tabs-mode nil)
 '(indicate-empty-lines t)
 '(inhibit-startup-screen t)
 '(ns-alternate-modifier 'meta)
 '(ns-command-modifier 'super)
 '(ns-right-command-modifier 'super)
 '(package-selected-packages
   '(prettify-math prettify-greek fira-code-mode auto-dictionary org-fancy-priorities org-clock-reminder org-clock-today org-gcal org-agenda-property org-analyzer org-beautify-theme org-bullets org-habit-stats org-hyperscheduler org-sync org-tag-beautify zygospore tokei smartparens dr-racket-like-unicode flycheck-pest flycheck-projectile geiser-gambit geiser-gauche macrostep-geiser coverage coverlay web-beautify web-mode xref-js2 js2hl js2-refactor js2-highlight-vars js2-mode zmq vterm wakatime-mode emacsql-sqlite-module toml-mode flycheck-yamllint yaml-mode json-mode csv-mode pcsv flycheck-package package-lint scheme-complete quack geiser-racket geiser-chez elisp-slime-nav slime-repl-ansi-color slime-company slime scribble-mode toml pest-mode flycheck-rust rustic rust-playground rust-auto-use cargo-mode tabspaces find-file-in-project project-persist project-explorer projectile-ripgrep projectile-git-autofetch verb dap-mode lsp-ui lsp-mode diff-hl forge magithub magit-todos magit-filenotify magit-lfs bug-reference-github github-review github-pullrequest github-notifier github-explorer github-browse-file git-modes git-timemachine git-link git-blamed git-attr smog bibtex-utils bibretrieve latex-extra latex-math-preview latex-preview-pane focus olivetti jinja2-mode easy-jekyll markdown-mode license-snippets gitignore-snippets yasnippet-snippets hl-todo flyspell-correct-ivy ivy-todo ivy-yasnippet ivy-rich ivy-prescient ivy-omni-org ivy-historian ivy-file-preview ivy-explorer ivy-emoji ivy-bibtex smex counsel-web counsel-test counsel-projectile counsel-osx-app counsel-org-capture-string counsel-fd counsel company-web company-quickhelp company-prescient company-org-block company-math company-emoji company-bibtex company mexican-holidays flycheck-plantuml plantuml-mode graphviz-dot-mode ox-wk ox-gfm ob-rust ob-latex-as-png org-timeline org-superstar org-sticky-header org-sidebar org-ref-prettify org-ql org-modern org-doing org-alert osx-trash reveal-in-osx-finder osx-plist osx-org-clock-menubar osx-lib page-break-lines smart-tabs-mode rainbow-delimiters aggressive-indent highlight-indent-guides undo-tree persist everlasting-scratch mc-extras multiple-cursors multicolumn color-theme-sanityinc-solarized ibuffer-sidebar ibuffer-projectile ibuffer-git dired-sidebar dir-treeview buffer-move buffer-expose major-mode-icons mode-icons all-the-icons-dired all-the-icons-completion all-the-icons))
 '(pe/omit-gitignore t)
 '(ring-bell-function 'ignore)
 '(scroll-bar-mode nil)
 '(scroll-margin 1)
 '(scroll-step 1)
 '(sentence-end-double-space nil)
 '(set-language-environment "UTF-8")
 '(smithy-mode-toolchain 'aws)
 '(tab-always-indent 'complete)
 '(tab-width 4)
 '(tool-bar-mode nil))

;; --------------------------------------------------------------------------
(init-message "Setting custom faces")
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

