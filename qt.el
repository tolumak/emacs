(setq qt4-base-dir "/usr/include/")

;; from http://www.users.on.net/~markwright/?x=entry:entry081126-020648
(defun qt-lineup-topmost-intro-cont (langelem)
  (let ((previous-point (point))(previous-line-end-position (line-end-position)))
    (save-excursion
      ;; Go back to the previous non-blank line, if any.
      (while
          (progn
            (forward-line -1)
            (back-to-indentation)
            (and (> (point) (c-langelem-pos langelem))
                 (looking-at "[ \t]*$"))))
      (if (search-forward "Q_OBJECT" (line-end-position) t)
          (if (or (re-search-forward "private[ \t]*:" previous-line-end-position t)
                  (re-search-forward "protected[ \t]*:" previous-line-end-position t)
                  (re-search-forward "public[ \t]*:" previous-line-end-position t)
                  (re-search-forward "signals[ \t]*:" previous-line-end-position t)
                  )
              '-
            '0
            )
        (progn
          (goto-char previous-point)
          (c-lineup-topmost-intro-cont langelem)
          )
        )
      )
    )
  )


;; from http://www.users.on.net/~markwright/?x=entry:entry081126-020648
(defun qt-lineup-inher-cont (langelem)
  (let ((previous-point (point))(previous-line-end-position (line-end-position)))
    (save-excursion
      ;; Go back to the previous non-blank line, if any.
      (while
          (progn
            (forward-line -1)
            (back-to-indentation)
            (and (> (point) (c-langelem-pos langelem))
                 (looking-at "[ \t]*$"))))
      (if (search-forward "Q_OBJECT" (line-end-position) t)
          (if (or (re-search-forward "private[ \t]+slots[ \t]*:" previous-line-end-position t)
                  (re-search-forward "protected[ \t]+slots[ \t]*:" previous-line-end-position t)
                  (re-search-forward "public[ \t]+slots[ \t]*:" previous-line-end-position t)
                  (re-search-forward "private[ \t]+signals[ \t]*:" previous-line-end-position t)
                  (re-search-forward "protected[ \t]+signals[ \t]*:" previous-line-end-position t)
                  (re-search-forward "public[ \t]+signals[ \t]*:" previous-line-end-position t)
                  )
              '-
            '0
            )
        (progn
          (goto-char previous-point)
          (c-lineup-multi-inher langelem)
          )
        )
      )
    )
  )


(defun qt4-inc-dir()
  (split-string
   (shell-command-to-string
    (concat "cd " qt4-base-dir " && find ./ -name 'Qt*' -type d | sed 's#./# " qt4-base-dir "#'")))
)

(when (require 'ede nil t)

(defun new-qt4-project (project_name project_dir style hook)
  (setq project (new-ede-project project_name project_dir style hook))

  (setq inc-dirs (list qt4-base-dir))
  (nconc inc-dirs (oref project system-include-path))
  (nconc inc-dirs (qt4-inc-dir))
  (oset project system-include-path inc-dirs)

  (add-to-list 'auto-mode-alist (cons (expand-file-name qt4-base-dir) 'c++-mode))
  (add-to-list 'auto-mode-alist (cons (expand-file-name project_dir) 'c++-mode))
  (add-to-list 'semantic-lex-c-preprocessor-symbol-file (concat qt4-base-dir "Qt/qconfig.h"))
  (add-to-list 'semantic-lex-c-preprocessor-symbol-file (concat qt4-base-dir "Qt/qconfig-dist.h"))
  (add-to-list 'semantic-lex-c-preprocessor-symbol-file (concat qt4-base-dir "Qt/qglobal.h"))

  (add-to-list 'semantic-lex-c-preprocessor-symbol-map '("Q_GUI_EXPORT" . ""))
  (add-to-list 'semantic-lex-c-preprocessor-symbol-map '("Q_CORE_EXPORT" . ""))
  (add-to-list 'semantic-lex-c-preprocessor-symbol-map '("Q_SQL_EXPORT" . ""))
  (add-to-list 'semantic-lex-c-preprocessor-symbol-map '("Q_NETWORK_EXPORT" . ""))
  (add-to-list 'semantic-lex-c-preprocessor-symbol-map '("Q_SVG_EXPORT" . ""))
  (add-to-list 'semantic-lex-c-preprocessor-symbol-map '("Q_OPENGL_EXPORT" . ""))
  (add-to-list 'semantic-lex-c-preprocessor-symbol-map '("Q_XML_EXPORT" . ""))
  (add-to-list 'semantic-lex-c-preprocessor-symbol-map '("Q_XMLPATTERNS_EXPORT" . ""))
  (add-to-list 'semantic-lex-c-preprocessor-symbol-map '("Q_SCRIPT_EXPORT" . ""))
  (add-to-list 'semantic-lex-c-preprocessor-symbol-map '("Q_SCRIPTTOOLS_EXPORT" . ""))
  (add-to-list 'semantic-lex-c-preprocessor-symbol-map '("Q_COMPAT_EXPORT" . ""))

  project
)
)

(font-lock-add-keywords 'c++-mode '(("\\<\\(Q_OBJECT\\)\\>" . font-lock-constant-face)))
(font-lock-add-keywords 'c++-mode '(("\\<\\(public slots\\|public signals\\|private slots\\|private signals\\|protected slots\\|protected signals\\|signals\\)\\>" . font-lock-keyword-face)))
