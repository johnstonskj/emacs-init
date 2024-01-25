(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-show-quick-access t nil nil "Customized with use-package company")
 '(custom-enabled-themes '(sanityinc-solarized-light))
 '(custom-safe-themes
   '("4cf3221feff536e2b3385209e9b9dc4c2e0818a69a1cdb4b522756bcdf4e00a4" default))
 '(ob-sdml-cmd "sdml")
 '(org-safe-remote-resources
   '("\\`https://fniessen\\.github\\.io/org-html-themes/org/theme-readtheorg\\.setup\\'"))
 '(package-selected-packages
   '(seq typescript-mode flycheck-css-colorguard scss-mode flycheck-guile geiser-guile slime magit-gh-pulls qrencode adaptive-wrap visual-fill-column flycheck-indicator ob-html-chrome ob-graphql graphql-mode html-check-frag ob-http amz-workspace amz-common ion-mode ansi pr-review org-assistant swagg org-autolist all-the-icons-nerd-fonts nerd-icons-ivy-rich nerd-icons-ibuffer nerd-icons-dired nerd-icons-completion nerd-icons json-reformat http company-mathedit-indirect-region-latex org-edit-indirect edit-indirect org-projectile pseudocode-mode geiser-repl mermaid-mode regex-tool visual-regexp-steroids visual-regexp company-lua lua-mode fringe-helper ts-fold tree-sitter-ispell tree-sitter-indent vimrc-mode ascii-table jq-mode recentf flyspell-lazy tree-sitter-langs tree-sitter flycheck-elsa elsa eval-expr flycheck-cask cask-mode ipretty eros highlight-quoted highlight-defined company-tabnine string-edit-at-point elisp-docstring-mode org-outline-numbering erefactor ivy-hydra org-ai major-mode-hydra mo-git-blame emr paredit use-package-ensure-system-package system-packages expand-region ttl-mode esup smithy-mode flycheck-eldev eldev yaml-pro yaml-imenu cov lorem-ipsum skj-secrets vscode-icon all-thes-icons all-the-icons-ivy all-the-icons-ivy-rich counsel ivy ivy-avy js2-mode treemacs treemacs-all-the-icons treemacs-icons-dired treemacs-magit treemacs-projectile iso-transl diminish pkg-overview edit-list toggle-test ert-modeline ert-expectations mastodon mastadon org-agenda flycheck-inline flycheck-relint ob-dart hover flutter-l10n-flycheck flutter lsp-dart swagger-to-org json-navigator zmq yasnippet-snippets xwiki-mode xref-js2 writegood-mode web-mode web-beautify wakatime-mode vterm verb use-package undo-tree ts-comint toml-mode toml tide tabspaces sqlformat sparql-mode smog smartparens smart-tabs-mode slime-repl-ansi-color slime-company show-css scribble-mode scheme-complete rustic rust-playground rust-auto-use rfc-mode reveal-in-osx-finder restclient-test react-snippets rdf-prefix rainbow-delimiters racket-mode quack proof-general projectile-ripgrep projectile-git-autofetch project-explorer prettify-math prettify-greek poly-markdown pcsv pass page-break-lines ox-wk ox-mediawiki ox-gfm osx-trash osx-plist osx-lib org-transclusion org-timeline org-tag-beautify org-sync org-superstar org-sticky-header org-sidebar org-ref-prettify org-modern org-ivy-search org-habit-stats org-gcal org-fragtog org-fancy-priorities org-edna org-dashboard org-contrib org-clock-reminder org-bullets org-beautify-theme org-appear org-analyzer org-alert org-agenda-property ob-typescript ob-sql-mode ob-rust ob-restclient ob-latex-as-png nnhackernews multicolumn mode-icons mexican-holidays mediawiki mc-extras major-mode-icons magit-todos magit-org-todos magit-lfs magit-filenotify magit-diff-flycheck macrostep-geiser lsp-ui lsp-scheme lsp-ivy license-snippets latex-preview-pane latex-pretty-symbols latex-math-preview latex-extra json-mode js2hl js2-refactor js2-highlight-vars jinja2-mode jekyll-modes ivy-yasnippet ivy-todo ivy-prescient ivy-pass ivy-omni-org ivy-historian ivy-file-preview ivy-explorer ivy-emoji ivy-bibtex idle-org-agenda ibuffer-vc ibuffer-sidebar ibuffer-projectile ibuffer-git highlight-indent-guides gscholar-bibtex graphviz-dot-mode gnuplot gitignore-snippets github-review github-pullrequest github-notifier github-explorer github-browse-file git-timemachine git-modes git-link git-blamed git-attr geiser-racket geiser-gauche geiser-gambit geiser-chez gameoflife format-sql fontawesome focus flyspell-correct-ivy flymake-sqlfluff flymake-pest flycheck-yamllint flycheck-rust flycheck-projectile flycheck-plantuml flycheck-pest flycheck-package flycheck-color-mode-line flycheck-cfn fira-code-mode find-file-in-project everlasting-scratch emacsql-sqlite-module elisp-slime-nav ebnf-mode easy-jekyll dr-racket-like-unicode docker-tramp dired-sidebar dir-treeview diff-hl dap-mode csv-mode coverlay coverage counsel-web counsel-tramp counsel-test counsel-projectile counsel-osx-app counsel-org-capture-string counsel-fd counsel-css coq-commenter company-web company-restclient company-quickhelp company-prescient company-org-block company-emojify company-emoji company-coq company-bibtex company-auctex color-theme-sanityinc-solarized code-review citar cfn-mode cargo-mode cakecrumbs bug-reference-github buffer-move buffer-expose boogie-friends bnf-mode bibtex-utils bibretrieve axe awscli-capf aws-snippets auto-rename-tag auto-package-update auto-dictionary auto-compile auctex-latexmk asm-blox all-the-icons-ibuffer all-the-icons-gnus all-the-icons-dired all-the-icons-completion aggressive-indent accent ac-html-csswatcher ac-html-bootstrap))
 '(safe-local-variable-values
   '((org-publish-project-alist
      ("work-docs" :base-directory "~/Projects/Amazon/SimonjoDocuments/projects/" :base-extension "org" :exclude "archive/.*\\|templates/download/.*" :recursive t :section-numbers nil :with-toc nil :publishing-directory "~/amazon-drive/projects/" :publishing-function org-html-publish-to-html :auto-sitemap t :sitemap-sort-files alphabetically :sitemap-sort-folders first)
      ("work-static" :base-directory "~/Projects/Amazon/SimonjoDocuments/projects/" :base-extension "css\\|js\\|png\\|jpg\\|jpeg\\|gif\\|pdf\\|svg\\|docx" :exclude "archive/.*\\|templates/.*" :recursive t :publishing-directory "~/amazon-drive/projects/" :publishing-function org-publish-attachment)
      ("work-templates" :base-directory "~/Projects/Amazon/SimonjoDocuments/projects/templates/" :exclude "/*-view.org" :recursive t :publishing-directory "~/amazon-drive/projects/templates/" :publishing-function org-publish-attachment)
      ("work" :components
       ("work-docs" "work-static" "work-templates")))
     (org-publish-project-alist
      ("work-docs" :base-directory "~/Projects/Amazon/SimonjoDocuments/projects/" :base-extension "org" :exclude "archive/.*\\|templates/download/.*" :recursive t :section-numbers nil :with-toc nil :publishing-directory "~/amazon-drive/projects/" :publishing-function org-html-publish-to-html :auto-sitemap t :sitemap-sort-files alphabetically :sitemap-sort-folders first)
      ("work-static" :base-directory "~/Projects/Amazon/SimonjoDocuments/projects/" :base-extension "css\\|js\\|png\\|jpg\\|jpeg\\|gif\\|pdf\\|svg\\|docx" :exclude "archive/.*\\|templates/*.org" :recursive t :publishing-directory "~/amazon-drive/projects/" :publishing-function org-publish-attachment)
      ("work-templates" :base-directory "~/Projects/Amazon/SimonjoDocuments/projects/templates/" :recursive t :publishing-directory "~/amazon-drive/projects/templates/" :publishing-function org-publish-attachment)
      ("work" :components
       ("work-docs" "work-static" "work-templates")))))
 '(tree-sitter-debug-highlight-jump-region t)
 '(tree-sitter-debug-jump-buttons t)
 '(world-clock-list
   '(("Etc/UTC" "UTC")
     ("America/Los_Angeles" "Seattle")
     ("America/New_York" "New York")
     ("Europe/Athens" "Athens")
     ("Pacific/Auckland" "Auckland")
     ("Asia/Shanghai" "Shanghai")) nil nil "Customized with use-package time")
 '(world-clock-time-format "%a, %d %b %I:%M %p %Z" nil nil "Customized with use-package time"))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
