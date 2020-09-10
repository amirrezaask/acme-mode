;;; acme.el --- Acme mode                            -*- lexical-binding: t; -*-

;; Copyright (C) 2020  AmirrezaAskarpour

;; Author: AmirrezaAskarpour(defun acme/--active-region () <raskarpour@gmail.com>
;; Keywords: 

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; Acme functionality in Emacs.

;;; Code:

(defun acme/--active-region ()
  "Get the content of the active region."
  (interactive)
  (buffer-substring (region-beginning) (region-end)))

(defun acme/--exec-command-from-region (cmd)
  "Execute CMD in an async process."
  (interactive)
  (start-process-shell-command cmd (buffer-name) cmd))

(defun acme/--output-buffer-name ()
  "Return buffer name for output buffer."
  (format "ACME: %s" default-directory))

(defun acme/--is-acme-result-buffer (name)
  "return non-nil if given buffer is Acme buffer."
  (setq-local case-fold-search nil)
  (string-match-p "ACME.*" name))

(defun acme/--new-window-and-switch (cmd)
  "Create a new window called CMD and switch to it."
  (let ((buff-name (acme/--output-buffer-name)))
    (unless
        (acme/--is-acme-result-buffer (buffer-name (current-buffer)))
      (split-window-below)
      (other-window 1))
    (switch-to-buffer buff-name)))

;;;###autoload
(defun acme/exec-command-in-region ()
  "Execute selected command in region."
  (interactive)
  (let ((cmd (acme/--active-region)))
    (acme/--new-window-and-switch cmd)
    (acme/--exec-command-from-region cmd)))

;;;###autoload
(defun acme/open-path-in-region ()
  "Open path in region."
  (interactive)
  (let ((path (acme/--active-region)))
    (acme/--new-window-and-switch path)
    (find-file path)))
  
(define-minor-mode acme-mode
  "Acme simulation layer for Emacs."
  :global t)


(provide 'acme)
;;; acme.el ends here
