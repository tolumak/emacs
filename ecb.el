;;;;;;;;;;;;;;;;;;;;;;;;
;;; ecb
;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'load-path
                 "/usr/share/emacs/site-lisp/ecb")

(require 'ecb)
;;(require 'ecb-autoloads)

(setq ecb-options-version "2.40")
(setq ecb-auto-activate nil)
(setq ecb-compile-window-height 5)
(setq ecb-layout-name "leftright1")
(setq ecb-source-path (quote ("/usr/share/emacs/site-lisp/ecb")))
(setq ecb-tip-of-the-day nil)

(if (frame-parameter nil 'display) (set-face-font 'ecb-default-general-face (frame-parameter nil 'font) ))