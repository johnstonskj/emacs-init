;;; skj-packages.el -*- lexical-binding: t; -*-
 
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

;; do: M-x package-refresh-contents

;; --------------------------------------------------------------------------
;; Package Sync Configuration
;; set up package syncing to allow for syncing between different machines
;; list of packages to sync
(setq pfl-packages
      '(
        ;; ------------------------------------------------------------------
        ;; Language-neutral customization
        all-the-icons
        all-the-icons-completion
        all-the-icons-dired

        mode-icons
        major-mode-icons

        buffer-expose
        buffer-move

        dir-treeview
        dired-sidebar
        
        ibuffer-git
        ibuffer-projectile
        ibuffer-sidebar
        
        color-theme-sanityinc-solarized

        multicolumn
        multiple-cursors
        mc-extras

        everlasting-scratch
        persist        
        undo-tree

        highlight-indent-guides
        aggressive-indent

        rainbow-delimiters
        smart-tabs-mode
        page-break-lines

        ;; ------------------------------------------------------------------
        ;; macOS specifics
        osx-lib
        osx-org-clock-menubar
        osx-plist
        reveal-in-osx-finder
        osx-trash
        
        ;; ------------------------------------------------------------------
        ;; Org mode
        org-alert
        org-doing
        org-gcal
        org-modern
        org-ql
        org-ref
        org-ref-prettify
        org-sidebar
        org-sticky-header
        org-superstar
        org-super-agenda
        org-timeline
        
        ob-latex-as-png
        ob-rust

        ox-gfm
        ox-wk
        
        graphviz-dot-mode
        plantuml-mode
        flycheck-plantuml

        mexican-holidays

        ;; ------------------------------------------------------------------
        ;; Completion
        company
        company-bibtex
        company-emoji
        company-math
        company-org-block
        company-prescient
        company-quickhelp
        company-web

        counsel
        counsel-fd
        counsel-org-capture-string
        counsel-osx-app
        counsel-projectile
        counsel-test
        counsel-web

        smex

        ivy-action
        ivy-bibtex
        ivy-emoji
        ivy-explorer
        ivy-file-preview
        ivy-historian
        ivy-omni-org
        ivy-prescient
        ivy-rich
        ivy-yasnippet
        ivy-todo
        
        flyspell-correct-ivy

        ;; ------------------------------------------------------------------
        ;; Generic development-like
        hl-todo
        
        yasnippet
        yasnippet-snippets
        gitignore-snippets
        license-snippets
        
        ;; ------------------------------------------------------------------
        ;; Writing modes
        markdown-mode
        markdown-mode+

        easy-jekyll

        jinja2-mode
        
        olivetti           ; distraction-free writing

        focus
        
        latex-preview-pane ; (latex-preview-pane-enable)
        latex-math-preview ; M-x latex-math-preview-expression
        latex-extra

        biblio
        bibretrieve
        bibtex-utils

        smog               ; check writing style: M-x smog-check-buffer

        ;; ------------------------------------------------------------------
        ;; Git interfaces
        git-attr
        git-blamed
        git-link
        git-timemachine
        git-modes

        github
        github-browse-file
        github-explorer ; M-x github-explorer "txgvnn/github-explorer"
        github-notifier
        github-pullrequest
        github-review
        bug-reference-github

        magit
        magit-lfs
        magit-filenotify
        magit-todos
        magithub
        
        forge

        diff-hl

        ;; ------------------------------------------------------------------
        ;; Core out-of-process integrations
        lsp-mode
        lsp-ui

        dap-mode

        verb
        
        ;; cov

        ;; ------------------------------------------------------------------
        ;; Project support
        projectile
        projectile-git-autofetch
        projectile-ripgrep

        project-explorer
        project-persist
        find-file-in-project

        tabspaces
        
        ;; ------------------------------------------------------------------
        ;; Rust Development
        cargo-mode
        rust-auto-use
        rust-playground
        rustic
        flycheck-rust

        pest-mode
        
        toml

        ;; ------------------------------------------------------------------
        ;; Scheme/Lisp Development
        racket-mode
        scribble-mode
        
        slime
        slime-company
        slime-repl-ansi-color
        elisp-slime-nav

        geiser
        geiser-chez
        geiser-racket

        quack

        scheme-complete

        package-lint
        flycheck-package

        ;; ------------------------------------------------------------------
        ;; Data/Config file formats
        pcsv
        csv-mode
        
        json-mode
        
        yaml-mode
        flycheck-yamllint
        
        toml-mode

        ;; ------------------------------------------------------------------
        ;; Database
        emacsql
        emacsql-sqlite-module

        ;; ------------------------------------------------------------------
        ;; Hosted service integrations
        wakatime-mode
        ))

;; refresh package list if it is not already available
(when (not package-archive-contents)
  (init-message "Refreshing package list" 'skj-packages)
  (package-refresh-contents))

;; install packages from the list that are not yet installed
(dolist (pkg pfl-packages)
  (init-message (format "Checking for package %s" pkg) 'skj-packages)
  (when (and (not (package-installed-p pkg)) (assoc pkg package-archive-contents))
    (package-install pkg)))

(provide 'skj-packages)
