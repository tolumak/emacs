(modify-frame-parameters nil '((wait-for-wm . nil)))

(require 'color-theme)

;;;;;;;;;;;;;;;;;;;;;;;;
;;; Fullscreen
;;;;;;;;;;;;;;;;;;;;;;;;
(defun fullscreen ()
(interactive)
(set-frame-parameter nil 'fullscreen
  (if (frame-parameter nil 'fullscreen) nil 'fullboth)))


;;;;;;;;;;;;;;;;;;;;;;;;
;;; X11 configuration
;;;;;;;;;;;;;;;;;;;;;;;;

(when (not (eq (symbol-value 'window-system) nil))
  (color-theme-initialize)
  (color-theme-midnight)
  (tool-bar-mode)
  (set-frame-parameter nil 'fullscreen 'fullboth)
  )

;;;;;;;;;;;;;;;;;;;;;;;;
;;; C styles
;;;;;;;;;;;;;;;;;;;;;;;;
(defconst my-style
  '((c-basic-offset . 4) (c-offsets-alist
			  (substatement-open . 0)
			  (case-label . +)
			  ))  "GNU style with basic-offset 4 and open-brace offset 0")

(defconst isc-style
  '((indent-tabs-mode . t) (c-basic-offset . 8) ) "ISC style")


(c-add-style "mine" my-style)
(c-add-style "isc"  isc-style)


;;;;;;;;;;;;;;;;;;;;;;;;
;;; Variables
;;;;;;;;;;;;;;;;;;;;;;;;

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(backup-directory-alist (quote (("." . "~/emacs/backup"))))
 '(c-default-style (quote ((other . "linux"))))
 '(column-number-mode t)
 '(ecb-auto-activate nil)
 '(ecb-compile-window-height 5)
 '(ecb-layout-name "leftright1")
 '(ecb-layout-window-sizes (quote (("leftright1" (ecb-directories-buffer-name 0.1897810218978102 . 0.359375) (ecb-sources-buffer-name 0.1897810218978102 . 0.3125) (ecb-history-buffer-name 0.1897810218978102 . 0.3125) (ecb-methods-buffer-name 0.354014598540146 . 0.984375)))))
 '(ecb-options-version "2.40")
 '(ecb-source-path (quote ("/usr/share/emacs/site-lisp/ecb")))
 '(ecb-tip-of-the-day nil)
 '(gdb-many-windows nil)
 '(gdb-memory-format "x")
 '(gud-gdb-command-name "/opt/eldk/usr/bin/ppc-linux-gdb --annotate=3")
 '(indent-tabs-mode t)
 '(inhibit-startup-screen t)
 '(max-specpdl-size 2500)
 '(show-paren-mode t)
 '(which-function-mode nil))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(ecb-default-highlight-face ((((class color) (background light)) (:foreground "yellow"))))
 '(font-lock-keyword-face ((((class color) (min-colors 8)) (:foreground "cyan"))))
 '(minibuffer-prompt ((t nil))))


;;;;;;;;;;;;;;;;;;;;;;;;
;;; Default font
;;;;;;;;;;;;;;;;;;;;;;;;
;;(set-frame-parameter nil 'width 234)
;;(set-frame-parameter nil 'height 71)
;;(set-default-font "7x13" nil)

;;;;;;;;;;;;;;;;;;;;;;;;
;;; Key bindings
;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key [f2] 'menu-bar-open)
(global-set-key [f5] 'compile)
(global-set-key [f6] 'previous-error)
(global-set-key [f7] 'next-error)
(global-set-key [f9] 'shrink-window-horizontally)
(global-set-key [f10] 'shrink-window)
(global-set-key [f11] 'enlarge-window)
(global-set-key [f12] 'enlarge-window-horizontally)

;;;;;;;;;;;;;;;;;;;;;;;;
;;; Trailing whitespaces
;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'write-file-hooks 'delete-trailing-whitespace)

;;;;;;;;;;;;;;;;;;;;;;;;
;;; Linux coding style
;;;;;;;;;;;;;;;;;;;;;;;;
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
                         c-lineup-arglist-tabs-only))))))

(add-hook 'c-mode-hook
          (lambda ()
            (let ((filename (buffer-file-name)))
              ;; Enable kernel mode for the appropriate files
              (when (and filename
                         (string-match (expand-file-name "~/linux")
                                       filename))
                (setq indent-tabs-mode t)
                (c-set-style "linux-tabs-only")))))

;;;;;;;;;;;;;;;;;;;;;;;;
;;; GDB
;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'gdb-mode-hook
	  (lambda ()
	    (ecb-deactivate)
	    ))

;;;;;;;;;;;;;;;;;;;;;;;;
;;; Doxygen
;;;;;;;;;;;;;;;;;;;;;;;;
(require 'doxymacs)
(add-hook 'c-mode-common-hook'doxymacs-mode)
(defun my-doxymacs-font-lock-hook ()
    (if (or (eq major-mode 'c-mode) (eq major-mode 'c++-mode))
        (doxymacs-font-lock)))
(add-hook 'font-lock-mode-hook 'my-doxymacs-font-lock-hook)

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


;;;;;;;;;;;;;;;;;;;;;;;;
;;; Miscellanious
;;;;;;;;;;;;;;;;;;;;;;;;
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(setq inhibit-splash-screen t)

;;;;;;;;;;;;;;;;;;;;;;;;
;;; CEDET
;;;;;;;;;;;;;;;;;;;;;;;;
(load-file "/usr/share/emacs/site-lisp/cedet/common/cedet.el")

;;;;;;;;;;;;;;;;;;;;;;;;
;;; EDE
;;;;;;;;;;;;;;;;;;;;;;;;
(global-ede-mode 1)                      ; Enable the Project management system
(require 'ede)

(defun proj-inc-dir(project_dir)
  (split-string
   (shell-command-to-string
    (concat "cd " project_dir " && find ./ -type d | sed 's#./#/#'")))
)


(defun proj-doc-def(project_dir)
  (setq doc_dir (concat project_dir "/doc"))
  (setq xml_file (concat doc_dir "tags.xml"))
  (setq project_url (concat "file://" project_dir))
  (or (file-exists-p doc_dir) (shell-command-to-string (concat "mkdir " doc_dir)))

  (add-to-list 'doxymacs-doxygen-dirs (list project_dir xml_file project_url))
)

(defun new-ede-project (project_name project_dir)
  (setq file-project (concat project_dir "/Project.ede"))
  (or (file-exists-p file-project) (shell-command-to-string (concat "touch " file-project)))

  (proj-doc-def project_dir)

  (ede-cpp-root-project project_name
			:name (concat project_name " project")
			:file file-project
			:include-path (proj-inc-dir project_dir)
			:system-include-path '("/usr/include/")
;			:spp-table '(("isUnix" . "")
;				     ("BOOST_TEST_DYN_LINK" . ""))
			)
)

(defun new-backbone-project (project_name project_dir)
  (setq project (new-ede-project project_name project_dir))
  (object-add-to-list project :include-path "~/git-nt/backbone/soft/lib/include")
  (setq project project)
)

(new-backbone-project "backbone/mint" "~/git-nt/backbone/soft/mint")
(new-backbone-project "backbone/liblpc" "~/git-nt/backbone/soft/lib/liblpc")


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

(setq-default semanticdb-default-save-directory "/home/e_mlafon/emacs/semanticdb")
(setq-default srecode-map-save-file "/home/e_mlafon/emacs/srecode/srecode-map")

;; addtionnal shortcuts
(defun my-cedet-hook ()
  (local-set-key [(control return)] 'semantic-ia-complete-symbol)
  (local-set-key "\C-xt" 'semantic-analyze-proto-impl-toggle)
  (local-set-key "\C-ci" 'semantic-decoration-include-visit)
  (local-set-key "\C-ct" 'eassist-switch-h-cpp)
  (local-set-key "\C-ce" 'eassist-list-methods)
  (local-set-key "\C-c\C-r" 'semantic-symref-symbol)
  (local-set-key "\C-c!" 'semantic-ia-complete-symbol-menu)
  (local-set-key "\C-c>" 'semantic-complete-analyze-inline)
  (local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle)
  (local-set-key "\C-c-" 'senator-fold-tag)
  (local-set-key "\C-c+" 'senator-unfold-tag)
)
(add-hook 'c-mode-common-hook 'my-cedet-hook)

;; intellisense on '.' and '->'
(defun my-c-mode-cedet-hook ()
  (local-set-key "." 'semantic-complete-self-insert)
  (local-set-key ">" 'semantic-complete-self-insert)
;;  (local-set-key "." 'semantic-ia-complete-symbol-menu)
;;  (local-set-key ">" 'semantic-ia-complete-symbol-menu)
)
(add-hook 'c-mode-common-hook 'my-c-mode-cedet-hook)

;;;;;;;;;;;;;;;;;;;;;;;;
;;; ecb
;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'load-path
                 "/usr/share/emacs/site-lisp/ecb")

(require 'ecb)
;;(require 'ecb-autoloads)

(if (frame-parameter nil 'display) (set-face-font 'ecb-default-general-face (frame-parameter nil 'font) ))