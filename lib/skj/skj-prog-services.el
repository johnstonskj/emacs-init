;;; skj-prog-services.el -*- lexical-binding: t; -*-

;; --------------------------------------------------------------------------
;; Wakatime customization
;; https://wakatime.com/emacs
;; Set the API key in ~/.wakatime.cfg

(global-wakatime-mode)
(setq wakatime-cli-path "/usr/local/bin/wakatime-cli")

(provide 'skj-prog-services)
