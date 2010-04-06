;;;;;;;;;;;;;;;;;;;;;;;;
;;; Miscellanious
;;;;;;;;;;;;;;;;;;;;;;;;
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(setq inhibit-splash-screen t)
(setq column-number-mode t)
(setq backup-directory-alist (quote (("." . "~/emacs/backup"))))
(setq indent-tabs-mode t)
(setq max-specpdl-size 2500)

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(ecb-default-highlight-face ((((class color) (background light)) (:foreground "yellow"))))
 '(font-lock-keyword-face ((((class color) (min-colors 8)) (:foreground "cyan"))))
 '(minibuffer-prompt ((t nil))))
