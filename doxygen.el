;;;;;;;;;;;;;;;;;;;;;;;;
;;; Doxygen
;;;;;;;;;;;;;;;;;;;;;;;;
(require 'doxymacs)

(add-hook 'c-mode-common-hook'doxymacs-mode)

(defun my-doxymacs-font-lock-hook ()
    (if (or (eq major-mode 'c-mode) (eq major-mode 'c++-mode))
        (doxymacs-font-lock)))
(add-hook 'font-lock-mode-hook 'my-doxymacs-font-lock-hook)

(defun process-doxygen ()
  (interactive)
  (compile "doxygen ; doxytag -t doc/tags.xml doc/*.html")
)

(defconst doxymacs-my-function-comment-template
 '((let ((next-func (doxymacs-find-next-func)))
     (if next-func
	 (list
	  'l
	  "////////////////////////////////////////////////////////////////////////////////" '> 'n
	  "/// " 'p '> 'n
	  "///" '> 'n
	  (doxymacs-parm-tempo-element (cdr (assoc 'args next-func)))
	  "///" '> 'n
	  (unless (string-match
                   (regexp-quote (cdr (assoc 'return next-func)))
                   doxymacs-void-types)
	    '(l "/// " (doxymacs-doxygen-command-char)
		"return " (p "Returns: ") > n))
	  "////////////////////////////////////////////////////////////////////////////////" '>)
       (progn
	 (error "Can't find next function declaraton.")
	 nil))))
 "My template for function documentation.")

(setq doxymacs-doxygen-style "C++")
(setq doxymacs-function-comment-template doxymacs-my-function-comment-template)
