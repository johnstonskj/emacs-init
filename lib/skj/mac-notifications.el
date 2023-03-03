;;; mac-notifications.el --- Display Alerts on macOS -*- lexical-binding: t; -*-

;; Author: Simon Johnston <johnstonskj@gmail.com>
;; Keywords: notifications darwin
;; Version: 0.0.1

;;; License:

;; Copyright (c) 2023 Simon Johnston

;; Permission is hereby granted, free of charge, to any person obtaining a copy
;; of this software and associated documentation files (the "Software"), to deal
;; in the Software without restriction, including without limitation the rights
;; to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
;; copies of the Software, and to permit persons to whom the Software is
;; furnished to do so, subject to the following conditions:

;; The above copyright notice and this permission notice shall be included in all
;; copies or substantial portions of the Software.

;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
;; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
;; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
;; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
;; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
;; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
;; SOFTWARE.

;;; Commentary:

;; A lot of these exist out there, including `erc-notifier', some use the
;; =terminal-notifier= and some use the =alerter= executable. For this I
;; chose terminal notifier as alerter seems to have issues with macOS Monterey
;; (12.6).
;;
;; You'll need to install the command with mac ports,
;;
;; => sudo port install terminal-notifier=
;;
;; or homebrew.
;;
;; => brew install terminal-notifier=
;;
;; *Install this package.*
;;
;; TBD
;;
;; *Customization*
;;
;; =M-x customize-group= and enter `mac-notifications' =RET=.
;;
;; *Usage*
;;
;;   (mac-notifications-send
;;    "Something amusing happened"
;;    "Simon says...")
;;
;;   (mac-notifications-send/timed
;;    "10 minutes"
;;    "Something amusing happened"
;;    "Simon says...")
;;

;;; Code:

;; --------------------------------------------------------------------------
;; Section heading
;; --------------------------------------------------------------------------

(defconst mac-notifications--executable-name "terminal-notifier")

(defgroup mac-notifications nil
  "Customization group for macOS notifications package."
  :group 'environment
  :tag "Mac Notifications"
  :prefix "mac-notifications"
  :version "28.2")


(defcustom mac-notifications-bundle-id "org.gnu.Emacs"
  "The default bundle identifier to use for notifications."
  :group 'mac-notifications
  :type 'string)


(defcustom mac-notifications-command
  (if (eq system-type 'darwin)
      (executable-find mac-notifications--executable-name)
    nil)
  "The path to terminal-notifier."
  :group 'mac-notifications
  :type 'string)


(defcustom mac-notifications-default-title "Emacs"
  "The default notification title."
  :group 'mac-notifications
  :type 'string)


(defcustom mac-notifications-default-process-name
  mac-notifications--executable-name
  "The default notification title."
  :group 'mac-notifications
  :type 'string)


(defcustom mac-notifications-default-buffer-name
  (format "*%s*" mac-notifications-default-process-name)
  "The default notification title."
  :group 'mac-notifications
  :type 'string)


(defun mac-notifications-send (message &optional title)
  "Show a system notification containing MESSAGE, optionally with TITLE."
  (if mac-notifications-command
      (start-process mac-notifications-default-process-name
                     mac-notifications-default-buffer-name
                     mac-notifications-command
                     "-title" (or title mac-notifications-default-title)
                     "-message" message
                     "-activate"mac-notifications-bundle-id
                     "-sender" mac-notifications-bundle-id)
    (error "Could not send notification without %s executable"
           mac-notifications--executable-name)))


(defun mac-notifications-send/timed (time message &optional title)
  "Submit a notification (MESSAGE and TITLE) to be sent at a particular TIME."
  (interactive
   "sNotification when (e.g: 2 minutes, 60 seconds, 3 days): \nsMessage: \nsTitle: ")
  (run-at-time time
               nil
               (lambda (message title) (mac-notifications-send message title))
               message title))


(provide 'mac-notifications)

;;; mac-notifications.el ends here
