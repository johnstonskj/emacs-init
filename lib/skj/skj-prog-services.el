;;; skj-prog-services.el -*- lexical-binding: t; -*-

(init-message "Setting up external integrations" 'skj-prog-services)

;; --------------------------------------------------------------------------
;; Wakatime customization
;; https://wakatime.com/emacs
;; Set the API key in ~/.wakatime.cfg

(global-wakatime-mode)
(setq wakatime-cli-path "/opt/homebrew/bin/wakatime-cli")

(provide 'skj-prog-services)
