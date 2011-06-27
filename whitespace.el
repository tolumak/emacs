(defun c-common-whitespace-hook ()
  (whitespace-mode)
  )



(when
  (require 'whitespace nil t)
  (setq whitespace-line-column 80)
  (setq whitespace-style '(face trailing lines-tail empty))
  (add-hook 'c-mode-common-hook 'c-common-whitespace-hook t)
  )
