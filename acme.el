(defun acme/--active-region ()
  "Get the content of the active region."
  (interactive)
  (buffer-substring (region-beginning) (region-end)))


(defun acme/--exec-command-from-region (cmd)
  "Execute CMD in an async process."
  (interactive)
  (start-process-shell-command cmd (buffer-name) cmd))


(defun acme/--new-window-and-switch (cmd)
  "Create a new window called CMD and switch to it."
  (split-window-below)
  (other-window 1)
  (switch-to-buffer cmd))

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

(defun acme/--initialize ()
  "Initialize acme-mode."
  ;; Execute active region
  (global-set-key [mouse-2] 'acme/exec-command-in-region)
  (global-set-key (kbd "C-s-e") 'acme/exec-command-in-region)
  ;; open path in active region
  (global-set-key [mouse-3] 'acme/open-path-in-region)
  (global-set-key (kbd "C-s-o") 'acme/open-path-in-region))
  
(define-minor-mode acme-mode
  "Acme simulation layer for Emacs."
  :global t
  :after-hook (acme/--initialize))

(provide 'acme)
