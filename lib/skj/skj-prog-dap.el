;;; skj-prog-dap.el -*- lexical-binding: t; -*-

(require 'dap-mode)
(setq dap-auto-configure-features '(sessions locals controls tooltip))

(dap-register-debug-template "Rust::GDB Run Configuration"
                             (list :type "gdb"
                                   :request "launch"
                                   :name "GDB::Run"
                           :gdbpath "rust-gdb"
                                   :target nil
                                   :cwd nil))
(require 'dap-ui)
(setq dap-ui-controls-mode 1)

(dap-ui-mode 1)

;; enables mouse hover support
(dap-tooltip-mode 1)

;; use tooltips for mouse hover
;; if it is not enabled `dap-mode' will use the minibuffer.
(tooltip-mode 1)

;; displays floating panel with debug buttons
;; requies emacs 26+
(dap-ui-controls-mode 1)

;;(require 'dap-cpptools)

(provide 'skj-prog-dap)
