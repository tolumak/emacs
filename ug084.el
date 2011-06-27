(defconst rmz-style
  '(
    (tab-width . 3)
    (indent-tabs-mode . t)
;;    (c-basic-offset . 4)
    (c-offsets-alist
;;     (substatement-open . 0)
     )
    )
  "RMZ")

(defconst mv2-qt-style
  '("linux"
    (c-offsets-alist
;;     (topmost-intro-cont . qt-lineup-topmost-intro-cont)
 ;;    (inher-cont . qt-lineup-inher-cont)
     )
    )
  "mv2-qt")


(c-add-style "rmz" rmz-style)
(c-add-style "mv2-qt" mv2-qt-style)

(defun sise-project-hook ()
)

(defun new-sise-project (project_name project_dir style)
  (setq project (new-ede-project project_name project_dir style 'sise-project-hook))
  project
)

(defun mv2-project-hook ()
  (set (make-local-variable 'compile-command) "cd ~/Mv2/devenv/ ; . setenv.sh ; make -k")
)


(defun new-mv2-project (project_name project_dir)
  (setq project (new-ede-project project_name project_dir "linux-tabs-only" 'mv2-project-hook))
  (object-add-to-list project :include-path "~/Mv2/devenv/sysroot/usr/include")
  (object-add-to-list project :include-path "~/Mv2/devenv/sysroot/usr/include/dbus-1.0")
  (object-add-to-list project :include-path "~/Mv2/devenv/sysroot/usr/lib/dbus-1.0/include")
  project
)

(defun new-mv2-qt-project (project_name project_dir)
  (setq qt4-base-dir "~/Mv2/devenv/sysroot/usr/include")
  (setq project (new-qt4-project project_name project_dir "mv2-qt" 'mv2-project-hook))
  (object-add-to-list project :include-path "~/Mv2/devenv/sysroot/usr/include")
  (object-add-to-list project :include-path "~/Mv2/devenv/sysroot/usr/include/dbus-1.0")
  (object-add-to-list project :include-path "~/Mv2/devenv/sysroot/usr/lib/dbus-1.0/include")
  project
)

(new-sise-project "rmz" "~/RMZ" "rmz")
(new-mv2-project "mv2/libcdbus" "~/Mv2/apps/libcdbus")
(new-mv2-qt-project "mv2/helloworld" "~/Mv2/apps/helloworld")