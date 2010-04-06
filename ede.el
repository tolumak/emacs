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
  (setq xml_file (concat doc_dir "/tags.xml"))
  (setq project_url (concat "file://" doc_dir))
  (or (file-exists-p doc_dir) (shell-command-to-string (concat "mkdir " doc_dir)))

  (add-to-list 'doxymacs-doxygen-dirs (list project_dir xml_file project_url))
)

(defun new-ede-project (project_name project_dir)
  (setq file-project (concat project_dir "/Project.ede"))
  (or (file-exists-p file-project) (shell-command-to-string (concat "touch " file-project)))

  (proj-doc-def project_dir)

  ;; Load semanticdb cache
  (dolist (dir (proj-inc-dir project_dir)) (semanticdb-get-database (concat project_dir dir "/")))

  (ede-cpp-root-project project_name
			:name (concat project_name " project")
			:file file-project
			:include-path (proj-inc-dir project_dir)
			:system-include-path '("/usr/include/")
			)

)


