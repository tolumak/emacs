;;;;;;;;;;;;;;;;;;;;;;;;
;;; CEDET
;;;;;;;;;;;;;;;;;;;;;;;;

(defun is-out-of-tree-cedet()
  (file-exists-p "~/emacs/cedet/cedet-devel-load.el")
)

(defun out-of-tree-cedet-configuration()
  ;; Load CEDET.
  ;; See cedet/common/cedet.info for configuration details.
  ;; IMPORTANT: For Emacs >= 23.2, you must place this *before* any
  ;; CEDET component (including EIEIO) gets activated by another 
  ;; package (Gnus, auth-source, ...).

  (load-file "~/emacs/cedet/cedet-devel-load.el")

  (when (require 'cedet nil t)

    ;; Add further minor-modes to be enabled by semantic-mode.
    ;; See doc-string of `semantic-default-submodes' for other things
    ;; you can use here.
    (add-to-list 'semantic-default-submodes 'global-semantic-idle-summary-mode t)
    (add-to-list 'semantic-default-submodes 'global-semantic-idle-completions-mode t)
    (add-to-list 'semantic-default-submodes 'global-cedet-m3-minor-mode t)

    ;; Enable Semantic
    (semantic-mode 1)

    ;; Enable EDE (Project Management) features
    (global-ede-mode 1)

    ;; Load contrib
    (load-file "~/emacs/cedet/contrib/cedet-contrib-load.el")
    )
)

(defun built-in-cedet-configuration()

  (when (require 'semantic nil t)

    (setq semantic-default-submodes (quote (global-semantic-highlight-func-mode global-semantic-decoration-mode global-semantic-stickyfunc-mode global-semantic-idle-completions-mode global-semantic-idle-scheduler-mode global-semanticdb-minor-mode global-semantic-idle-summary-mode global-semantic-mru-bookmark-mode)))
    
    (semantic-mode t)
    )
)

(if (is-out-of-tree-cedet)
    ;; Configuration for cedet package
    (out-of-tree-cedet-configuration)
  
  ;; Configuration for built-in cedet
  (built-in-cedet-configuration)
)

;; This part works whether cedet is out-of-tree or not

(setq-default semanticdb-default-save-directory "~/emacs/semanticdb")
(setq-default semanticdb-default-system-save-directory "~/emacs/semanticdb")
(setq-default srecode-map-save-file "~/emacs/srecode/srecode-map")

;; addtionnal shortcuts
(defun my-cedet-hook ()
  (if (is-out-of-tree-cedet)
      (local-set-key [(control return)] 'semantic-ia-complete-symbol)
    (local-set-key [(control return)] 'semantic-complete-symbol)
    )
  (local-set-key "\C-xt" 'semantic-analyze-proto-impl-toggle)
  (local-set-key "\C-ci" 'semantic-decoration-include-visit)
  (local-set-key "\C-ct" 'eassist-switch-h-cpp)
  (local-set-key "\C-ce" 'eassist-list-methods)
  (local-set-key "\C-c\C-r" 'semantic-symref-symbol)
  (if (is-out-of-tree-cedet)
      (local-set-key "\C-c!" 'semantic-ia-complete-symbol-menu)
  )
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
