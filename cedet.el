;;;;;;;;;;;;;;;;;;;;;;;;
;;; CEDET
;;;;;;;;;;;;;;;;;;;;;;;;
;;(load-file "/usr/share/emacs/site-lisp/cedet/common/cedet.el")
(if (file-exists-p "~/emacs/cedet/common/cedet.el")
    (load-file "~/emacs/cedet/common/cedet.el")
  )

(when (require 'cedet nil t)

;;;;;;;;;;;;;;;;;;;;;;;;
;;; CEDET
;;;;;;;;;;;;;;;;;;;;;;;;

;; Enabling Semantic (code-parsing, smart completion) features
;; Select one of the following:

;; * This enables the database and idle reparse engines
;;(semantic-load-enable-minimum-features)

;; * This enables some tools useful for coding, such as summary mode
;;   imenu support, and the semantic navigator
;;(semantic-load-enable-code-helpers)

;; * This enables even more coding tools such as intellisense mode
;;   decoration mode, and stickyfunc mode (plus regular code helpers)
;;(semantic-load-enable-gaudy-code-helpers)

;; * This enables the use of Exuberent ctags if you have it installed.
;;   If you use C++ templates or boost, you should NOT enable it.
;; (semantic-load-enable-all-exuberent-ctags-support)

(semantic-load-enable-gaudy-code-helpers)

;; Enable SRecode (Template management) minor-mode.
;; (global-srecode-minor-mode 1)

;; ** additionnal semantic config
(require 'semantic-ia)

(setq-default semanticdb-default-save-directory "~/emacs/semanticdb")
(setq-default semanticdb-default-system-save-directory "~/emacs/semanticdb")
(setq-default srecode-map-save-file "~/emacs/srecode/srecode-map")

;; addtionnal shortcuts
(defun my-cedet-hook ()
  (local-set-key [(control return)] 'semantic-ia-complete-symbol)
  (local-set-key "\C-xt" 'semantic-analyze-proto-impl-toggle)
  (local-set-key "\C-ci" 'semantic-decoration-include-visit)
  (local-set-key "\C-ct" 'eassist-switch-h-cpp)
  (local-set-key "\C-ce" 'eassist-list-methods)
  (local-set-key "\C-c\C-r" 'semantic-symref-symbol)
  (local-set-key "\C-c!" 'semantic-ia-complete-symbol-menu)
  (local-set-key "\C-c:" 'semantic-complete-analyze-inline)
  (local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle)
  (local-set-key "\C-c-" 'senator-fold-tag)
  (local-set-key "\C-c+" 'senator-unfold-tag)
)
(add-hook 'c-mode-common-hook 'my-cedet-hook)

;; intellisense on '.' and '->'
;;(defun my-c-mode-cedet-hook ()
;;  (local-set-key "." 'semantic-complete-self-insert)
;;  (local-set-key ">" 'semantic-complete-self-insert)
;;  (local-set-key "." 'semantic-ia-complete-symbol-menu)
;;  (local-set-key ">" 'semantic-ia-complete-symbol-menu)
;;)
;;(add-hook 'c-mode-common-hook 'my-c-mode-cedet-hook)

)