(defun active-region ()
  (interactive)
  (buffer-substring (region-beginning) (region-end)))

;;;###autoload
(defun acme/--exec-command-from-region ()
  (interactive)
  (shell-command-to-string (active-region)))

(defun acme/--new-window-and-switch ()
  "Create a new window and switch to it."
  (split-window-right)
  (other-window 1))

(defun acme/exec-command ()
  "Execute selected command in region."
  (interactive)
  (acme/--new-window-and-switch)
  (acme/--exec-command-from-region))

(defun acme/initialize ()
  "Initialize acme-mode."
  (global-set-key [mouse-2] 'exec-command)
  (global-set-key (kbd "C-s-e") 'exec-command))
  
(define-minor-mode acme-mode "Acme simulation layer for Emacs."
  :global t
  :after-hook
  (acme/initialize))

(provide 'acme)
