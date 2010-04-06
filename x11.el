
;; Accelerate initialization
(modify-frame-parameters nil '((wait-for-wm . nil)))

;;;;;;;;;;;;;;;;;;;;;;;;
;;; Fullscreen
;;;;;;;;;;;;;;;;;;;;;;;;
(defun fullscreen ()
(interactive)
(set-frame-parameter nil 'fullscreen
  (if (frame-parameter nil 'fullscreen) nil 'fullboth)))
