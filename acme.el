(defun active-region ()
  (interactive)
  (buffer-substring (region-beginning) (region-end)))

(defun exec-command ()
  (interactive)
  (message (shell-command-to-string (active-region))))

(defun set-keys ()
  (global-set-key [mouse-2] 'exec-command))





echo 'salam'


(provide 'init)
