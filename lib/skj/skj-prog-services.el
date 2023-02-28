;;; skj-prog-services.el --- Online services -*- lexical-binding: t; -*-

;;; Code:

(init-message "Setting up external integrations" 'skj-prog-services)

;; --------------------------------------------------------------------------
;; Wakatime customization -- see https://wakatime.com/emacs
;; Set the API key in ~/.wakatime.cfg

(require 'skj-packages)

(skj-package-install 'wakatime-mode)

(global-wakatime-mode)
(setq wakatime-cli-path "/opt/homebrew/bin/wakatime-cli")

(provide 'skj-prog-services)
;;; skj-prog-services.el ends here
