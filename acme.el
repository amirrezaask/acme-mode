;;;###autoload
(defun acme/--active-region ()
  (interactive)
  (buffer-substring (region-beginning) (region-end)))

;;;###autoload
(defun acme/--exec-command-from-region (cmd)
  (interactive)
  (insert (shell-command-to-string cmd)))

(defun acme/--new-window-and-switch (cmd)
  "Create a new window and switch to it."
  (switch-to-buffer-other-window (format "*ACME:Exec %s" cmd)))

(defun acme/exec-command-in-region ()
  "Execute selected command in region."
  (interactive)
  (let ((cmd (acme/--active-region)))
    (acme/--new-window-and-switch cmd)
    (acme/--exec-command-from-region cmd)))

(defun acme/initialize ()
  "Initialize acme-mode."
  (global-set-key [mouse-2] 'acme/exec-command-in-region)
  (global-set-key (kbd "C-s-e") 'acme/exec-command-in-region))
  
(define-minor-mode acme-mode
  "Acme simulation layer for Emacs."
  :global t
  :after-hook (acme/initialize))

(provide 'acme)
