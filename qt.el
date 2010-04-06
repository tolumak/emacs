(setq qt4-base-dir "/usr/include/")

(defun qt4-inc-dir()
  (split-string
   (shell-command-to-string
    (concat "cd " qt4-base-dir " && find ./ -name 'Qt*' -type d | sed 's#./# " qt4-base-dir "#'")))
)


(defun new-qt4-project (project_name project_dir)
  (setq project (new-ede-project project_name project_dir))

  (setq inc-dirs (list qt4-base-dir))
  (nconc inc-dirs (oref project system-include-path))
  (nconc inc-dirs (qt4-inc-dir))
  (oset project system-include-path inc-dirs)

  (add-to-list 'auto-mode-alist (cons qt4-base-dir 'c++-mode))
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

  (setq project project)
)
