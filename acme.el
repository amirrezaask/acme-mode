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

(defun acme/--new-window-and-switch (cmd)
  "Create a new window called CMD and switch to it."
  ;; TODO: need more sophisticated implementation. if current window has an ACME buffer don't do anything
  (let ((buff-name (acme/--output-buffer-name)))
    (unless (or (get-buffer buff-name) (> (length (window-list)) 2))
      (split-window-below))
    (other-window 1)
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
