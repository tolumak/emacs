(load "~/.emacs.d/id.el")
(load "~/.emacs.d/x11.el")
(load "~/.emacs.d/color-theme.el")
(load "~/.emacs.d/gdb.el")
(load "~/.emacs.d/c-styles.el")
(load "~/.emacs.d/magit.el")
(load "~/.emacs.d/doxygen.el")
(load "~/.emacs.d/cscope.el")
(load "~/.emacs.d/cedet.el")
(load "~/.emacs.d/ede.el")
(load "~/.emacs.d/ecb.el")
(load "~/.emacs.d/qt.el")
(load "~/.emacs.d/kde.el")
(load "~/.emacs.d/gnutls.el")
(load "~/.emacs.d/gnus.el")
(load "~/.emacs.d/w3m.el")
(load "~/.emacs.d/key-bindings.el")
(load "~/.emacs.d/hooks.el")
(load "~/.emacs.d/custom.el")

;; Host specific configuration
(if (file-exists-p (concat "~/.emacs.d/" (system-name) ".el"))
    (load (concat "~/.emacs.d/" (system-name) ".el"))
  nil
  )


