;; Define e17 C coding style
(defconst e17-c-style
  '("gnu"
    (c-offsets-alist . (
			(defun-block-intro . 3)
			(statement-block-intro . 3)
			(case-label . 1)
			(statement-case-intro . 3)
			)
		     )
    )
  )

(add-hook 'c-mode-common-hook
	  (lambda ()
	    (c-add-style "e" e17-c-style)
	    )
	  )

;; edje-mode
(if (file-exists-p "~/.emacs.d/edje-mode.el")
    (load-file "~/.emacs.d/edje-mode.el")
  (require 'edje-mode)
  (setq auto-mode-alist
	(append
	 '(("\\.edc\\'" . edje-mode))
	 auto-mode-alist))
  )