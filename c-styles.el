;;;;;;;;;;;;;;;;;;;;;;;;
;;; C styles
;;;;;;;;;;;;;;;;;;;;;;;;
(defconst isc-style
  '((indent-tabs-mode . t) (c-basic-offset . 8) ) "ISC style")

(defconst ws-4-style
  '(
    (indent-tabs-mode . nil)
    (c-basic-offset . 4)
    (c-offsets-alist
     (substatement-open . 0)
     )
    )
  "No tab, 4 whitespaces")

(defconst ws-2-style
  '(
    (indent-tabs-mode . nil)
    (c-basic-offset . 2)
    (c-offsets-alist
     (substatement-open . 0)
     (case-label . +)
     )
    )
  "No tab, 2 whitespaces")


(defun c-lineup-arglist-tabs-only (ignored)
  "Line up argument lists by tabs, not spaces"
  (let* ((anchor (c-langelem-pos c-syntactic-element))
	 (column (c-langelem-2nd-pos c-syntactic-element))
	 (offset (- (1+ column) anchor))
	 (steps (floor offset c-basic-offset)))
    (* (max steps 1)
       c-basic-offset)))

(add-hook 'c-mode-common-hook
          (lambda ()
            ;; Add kernel style
            (c-add-style
             "linux-tabs-only"
             '("linux" (c-offsets-alist
                        (arglist-cont-nonempty
                         c-lineup-gcc-asm-reg
                         c-lineup-arglist-tabs-only)))
	     )
	    (c-add-style "isc"  isc-style)
	    (c-add-style "ws-4"  ws-4-style)
	    (c-add-style "ws-2"  ws-2-style)
	    )
)

(add-hook 'c-mode-hook
          (lambda ()
            (let ((filename (buffer-file-name)))
              ;; Enable kernel mode for the appropriate files
              (when (and filename
                         (string-match (expand-file-name "~/linux")
                                       filename))
                (setq indent-tabs-mode t)
                (c-set-style "linux-tabs-only")))))
