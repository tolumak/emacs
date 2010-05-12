(setq kde4-base-dir "/usr/include/")

(defconst kdelibs-style
  '((indent-tabs-mode . nil) (c-basic-offset . 4) (c-offsets-alist
			  (substatement-open . 0)
			  (case-label . 0)
			  (innamespace . 0)
			  (topmost-intro-cont . qt-lineup-topmost-intro-cont)
			  (inher-cont . qt-lineup-inher-cont)
			  ))  "KDE kdelibs C++-style")

(defconst kdepim-style
  '((indent-tabs-mode . nil) (c-basic-offset . 2) (c-offsets-alist
			  (substatement-open . 0)
			  (case-label . 0)
			  (innamespace . 0)
			  (topmost-intro-cont . qt-lineup-topmost-intro-cont)
			  (inher-cont . qt-lineup-inher-cont)
			  ))  "KDE kdepim C++-style")



(defun new-kde-project (project_name project_dir style)
  (setq project (new-qt4-project project_name project_dir style))

  (setq inc-dirs (list kde4-base-dir (concat kde4-base-dir "KDE/")))
  (nconc inc-dirs (oref project system-include-path))
  (oset project system-include-path inc-dirs)

  (add-to-list 'auto-mode-alist (cons kde4-base-dir 'c++-mode))
  (add-to-list 'semantic-lex-c-preprocessor-symbol-file (concat kde4-base-dir "kdemacros.h"))

  (add-to-list 'semantic-lex-c-preprocessor-symbol-map '("KATE_EXPORT" . ""))
  (add-to-list 'semantic-lex-c-preprocessor-symbol-map '("KATEINTERFACES_EXPORT" . ""))
  (add-to-list 'semantic-lex-c-preprocessor-symbol-map '("KDE3SUPPORT_EXPORT" . ""))
  (add-to-list 'semantic-lex-c-preprocessor-symbol-map '("KDECORE_EXPORT" . ""))
  (add-to-list 'semantic-lex-c-preprocessor-symbol-map '("KDE_EXPORT" . ""))
  (add-to-list 'semantic-lex-c-preprocessor-symbol-map '("KDE_FULL_TEMPLATE_EXPORT" . ""))
  (add-to-list 'semantic-lex-c-preprocessor-symbol-map '("KDE_NO_EXPORT" . ""))
  (add-to-list 'semantic-lex-c-preprocessor-symbol-map '("KDEUI_EXPORT" . ""))
  (add-to-list 'semantic-lex-c-preprocessor-symbol-map '("K_EXPORT" . ""))
  (add-to-list 'semantic-lex-c-preprocessor-symbol-map '("KFILE_EXPORT" . ""))
  (add-to-list 'semantic-lex-c-preprocessor-symbol-map '("KHTML_EXPORT" . ""))
  (add-to-list 'semantic-lex-c-preprocessor-symbol-map '("KIMPROXY_EXPORT" . ""))
  (add-to-list 'semantic-lex-c-preprocessor-symbol-map '("KIO_EXPORT" . ""))
  (add-to-list 'semantic-lex-c-preprocessor-symbol-map '("KNOTIFYCONFIG_EXPORT" . ""))
  (add-to-list 'semantic-lex-c-preprocessor-symbol-map '("KONQ_EXPORT" . ""))
  (add-to-list 'semantic-lex-c-preprocessor-symbol-map '("KONQSIDEBARPLUGIN_EXPORT" . ""))
  (add-to-list 'semantic-lex-c-preprocessor-symbol-map '("KPTY_EXPORT" . ""))
  (add-to-list 'semantic-lex-c-preprocessor-symbol-map '("KSPEECH_EXPORT" . ""))
  (add-to-list 'semantic-lex-c-preprocessor-symbol-map '("KUTILS_EXPORT" . ""))
  (add-to-list 'semantic-lex-c-preprocessor-symbol-map '("KWIN_EXPORT" . ""))

  project
)

(defun c-common-kde-hook ()
  (c-add-style "kdelibs"  kdelibs-style)
  (c-add-style "kdepim"   kdepim-style)
)

(add-hook 'c-mode-common-hook 'c-common-kde-hook)