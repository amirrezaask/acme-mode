# acme-mode
Emacs minor mode to make mouse behave like Acme.

# Example usage
```emacs-lisp
(use-package acme 
    :load-path "~/w/acme-mode"
    :bind (([mouse-3] . 'acme/open-path-in-region)
    ([mouse-2] . 'acme/exec-command-in-region)))
```
