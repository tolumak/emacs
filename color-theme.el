(require 'color-theme)

(when (not (eq (symbol-value 'window-system) nil))
  (color-theme-initialize)
  (color-theme-midnight)
  (tool-bar-mode -1)
;;  (set-frame-parameter nil 'fullscreen 'fullboth)
  )
