(set-face-attribute 'default nil :font "DejaVu Sans Mono 10")

(load "~/.emacs.d/id.el")
(load "~/.emacs.d/org.el")
(load "~/.emacs.d/cedet.el")
(load "~/.emacs.d/haskell.el")
(load "~/.emacs.d/yaml-mode.el")
(load "~/.emacs.d/x11.el")
(load "~/.emacs.d/color-theme.el")
(load "~/.emacs.d/gdb.el")
(load "~/.emacs.d/c-styles.el")
;;(load "~/.emacs.d/cmake.el")
(load "~/.emacs.d/e17.el")
(load "~/.emacs.d/whitespace.el")
(load "~/.emacs.d/magit.el")
(load "~/.emacs.d/doxygen.el")
(load "~/.emacs.d/cscope.el")
(load "~/.emacs.d/ede.el")
(load "~/.emacs.d/ecb.el")
(load "~/.emacs.d/qt.el")
(load "~/.emacs.d/kde.el")
;;(load "~/.emacs.d/gnutls.el")
;;(load "~/.emacs.d/gnus.el")
;;(load "~/.emacs.d/w3m.el")
(load "~/.emacs.d/key-bindings.el")
(load "~/.emacs.d/hooks.el")
(load "~/.emacs.d/custom.el")

;; Host specific configuration
(if (file-exists-p (concat "~/.emacs.d/" (system-name) ".el"))
    (load (concat "~/.emacs.d/" (system-name) ".el"))
  nil
  )

(desktop-save-mode 1)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(ecb-layout-window-sizes (quote (("leftright1" (ecb-directories-buffer-name 0.250936329588015 . 0.39436619718309857) (ecb-sources-buffer-name 0.250936329588015 . 0.29577464788732394) (ecb-history-buffer-name 0.250936329588015 . 0.29577464788732394) (ecb-methods-buffer-name 0.20599250936329588 . 0.9859154929577465)))))
 '(ecb-options-version "2.40"))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(ecb-default-highlight-face ((((class color) (background light)) (:foreground "yellow"))))
 '(font-lock-keyword-face ((((class color) (min-colors 8)) (:foreground "cyan"))))
 '(minibuffer-prompt ((t nil))))
