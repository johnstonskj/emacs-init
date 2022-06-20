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
 '(olivetti-body-width 82)
 '(package-selected-packages
   '(git-modes pcsv csv-mode find-file-in-project highlight-indent-guides major-mode-icons mode-icons zzz-to-char counsel-fd counsel-org-capture-string smex counsel-projectile counsel-osx-app counsel multiple-cursors consult-org-roam el-fetch emacsql-sqlite-module eslint-rc everlasting-scratch flymake-swi-prolog private-comments-mode shanty-themes tabspaces flycheck-package package-lint persist company-prescient project-explorer diff-hl magit-lfs magit-todos hl-todo forge org-sidebar osx-org-clock-menubar undo-tree company-web focus org-modern easy-jekyll dashboard-project-status dashboard-hackernews dashboard all-the-icons-dired all-the-icons-completion all-the-icons ## yasnippet-snippets yasnippet projectile dap-mode lsp-ui dir-treeview dired-sidebar github-pullrequest github-explorer git-link magithub magit-filenotify magit github-review github-notifier git-blamed git-attr scribble-mode smog latex-extra latex-math-preview latex-preview-pane lsp-mode flycheck-rust rustic rust-playground rust-auto-use wakatime-mode company rust-mode cargo-mode racket-mode))
 '(pe/omit-gitignore t)
 '(pixel-scroll-precision-mode 1 t)
 '(ring-bell-function 'ignore)
 '(save-place t t)
 '(scroll-bar-mode nil)
 '(scroll-margin 1)
 '(scroll-step 1)
 '(sentence-end-double-space nil)
 '(set-language-environment "UTF-8")
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

