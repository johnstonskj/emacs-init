;;; skj-org.el -*- lexical-binding: t; -*-

(init-message "[skj-location] Entered")

(setq calendar-latitude 47.6062
      calendar-longitude -122.3321
      calendar-location-name "Seattle, WA")

(setq calendar-time-zone -480
      calendar-standard-time-zone-name "PST"
      calendar-daylight-time-zone-name "PDT")

(setq skj-calendar-time-zone-name "America/Los_Angeles")

(provide 'skj-location)
