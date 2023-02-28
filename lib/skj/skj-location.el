;;; skj-location.el --- Set personal home location -*- lexical-binding: t; -*-

;;; Code:

(init-message "Setting location/time-zone" 'skj-location)

(require 'calendar)
(require 'cal-dst)
(require 'solar)

(setq calendar-latitude 47.6062
      calendar-longitude -122.3321
      calendar-location-name "Seattle, WA")

(setq calendar-time-zone -480
      calendar-standard-time-zone-name "PST"
      calendar-daylight-time-zone-name "PDT")

(provide 'skj-location)
;;; skj-location.el ends here
