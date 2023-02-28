;;; skj-ui-mac.el --- macOS specifics -*- lexical-binding: t; -*-

;;; Code:

(init-message "macOS specifics" 'skj-ui-mac)

(require 'skj-packages)

(skj-package-install
 '(osx-lib
   osx-org-clock-menubar
   osx-plist
   osx-trash
   reveal-in-osx-finder))


;; --------------------------------------------------------------------------
;; Keyboard

(init-message "ui > keyboard" 'skj-ui)

(setq mac-command-modifier 'super)        ; make cmd key do Super
(setq mac-right-command-modifier 'super)
(setq mac-option-modifier 'meta)          ; make opt key do Meta
(setq mac-right-option-modifier 'meta)
(setq mac-control-modifier 'control)      ; make Control key do Control

(setq ns-command-modifier 'super)
(setq ns-right-command-modifier 'super)
(setq ns-alternate-modifier 'meta)
(setq ns-function-modifier 'hyper)        ; make Fn key do Hyper


(provide 'skj-ui-mac)
;;; skj-ui-mac.el ends here
