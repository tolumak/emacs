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

(defconst sise-env-qt-style
  '("linux"
    (c-offsets-alist
;;     (topmost-intro-cont . qt-lineup-topmost-intro-cont)
 ;;    (inher-cont . qt-lineup-inher-cont)
     )
    )
  "sise-env-qt")


(c-add-style "rmz" rmz-style)
(c-add-style "sise-env-qt" sise-env-qt-style)

(defcustom sise-env-target nil "SISE Linux environment target")
(defcustom sise-env-compile-args "-j16 D=1 install" "SISE Linux environment compile flags")
(defcustom sise-env-target-ip nil "SISE Linux target IP address")


(defun ask-for-target (target)
  (interactive "MPlease specify the SISE Linux target: ")
  (setq sise-env-target target)
)

(defun ask-for-target-ip (target-ip)
  (interactive "MPlease specify the SISE Linux target IP address: ")
  (setq sise-env-target-ip target-ip)
)

(defun sise-project-hook ()
)

(defun new-sise-project (project_name project_dir style)
  (setq project (new-ede-project project_name project_dir style 'sise-project-hook))
  project
)

(defun copy-and-start ()
  (interactive)
  (unless sise-env-target-ip
    (call-interactively 'ask-for-target-ip)
    )
  (compile (format "target=`echo %s | sed 's#_#/#'` ip=%s; cd ~/sise-env/devenv/ ; . scripts/setenv.sh %s ; find ~/sise-env/devenv/$target/debug/usr -type f -executable -exec $TOOLCHAIN_PATH/bin/$TOOLCHAIN_PREFIX-strip -s '{}' \\\;  ; ssh root@$ip '/etc/init.d/S66guim stop ; /etc/init.d/S31controld stop ; /etc/init.d/S31udevmond stop' ; sleep 2 ; scp -r ~/sise-env/devenv/$target/debug/usr root@$ip:/ ; ssh root@$ip '/etc/init.d/S31controld start ; /etc/init.d/S31udevmond start ; /etc/init.d/S66guim start'" sise-env-target sise-env-target-ip sise-env-target))
)

(defun sise-env-compile ()
  (interactive)
  (compile (format "cd ~/sise-env/devenv/ ; . build.sh %s %s" sise-env-target sise-env-compile-args))
)

(defun sise-env-project-hook ()
  (unless sise-env-target
    (call-interactively 'ask-for-target)
    )
  (local-set-key [f4] 'copy-and-start)
  (local-set-key [f5] 'sise-env-compile)
)


(defun new-sise-env-project (project_name project_dir)
  (setq project (new-ede-project project_name project_dir "linux-tabs-only" 'sise-env-project-hook))
  (object-add-to-list project :include-path (format "~/targets/%s/sysroot/usr/include" sise-env-target))
  (object-add-to-list project :include-path (format "~/targets/%s/sysroot/usr/include/dbus-1.0" sise-env-target))
  (object-add-to-list project :include-path (format "~/targets/%s/sysroot/usr/lib/dbus-1.0/include" sise-env-target))
  project
)

(defun new-sise-env-qt-project (project_name project_dir)
  (setq qt4-base-dir "~/sise-env/devenv/sysroot/usr/include/")
  (setq project (new-qt4-project project_name project_dir "sise-env-qt" 'sise-env-project-hook))
  (object-add-to-list project :include-path (format "~/targets/%s/sysroot/usr/include" sise-env-target))
  (object-add-to-list project :include-path (format "~/targets/%s/sysroot/usr/include/dbus-1.0" sise-env-target))
  (object-add-to-list project :include-path (format "~/targets/%s/sysroot/usr/lib/dbus-1.0/include" sise-env-target))
  project
)

(new-sise-project "rmz" "~/RMZ" "rmz")
(new-sise-env-project "sise-env/libcdbus" "~/apps/libcdbus")
(new-sise-env-project "sise-env/moddump" "~/apps/moddump")
(new-sise-env-project "sise-env/rmzrecal" "~/apps/rmzrecal")
(new-sise-env-qt-project "sise-env/libqtsise" "~/apps/libqtsise")
(new-sise-env-qt-project "sise-env/guim" "~/apps/guim")
(new-sise-env-qt-project "sise-env/mv2cfg" "~/apps/mv2cfg")
(new-sise-env-qt-project "sise-env/plotplot" "~/apps/plotplot")
(new-sise-env-project "sise-env/controld" "~/apps/controld")
(new-sise-env-project "sise-env/udevmond" "~/apps/udevmond")
(new-sise-env-project "sise-env/libsiseconfig" "~/apps/libsiseconfig")
(new-sise-env-project "sise-env/libtchoutchou" "~/apps/libtchoutchou")
(new-sise-env-project "sise-env/thc" "~/apps/thc")
(new-sise-env-project "sise-env/mpc" "~/apps/mpc")
(new-sise-env-project "sise-env/libpiglet" "~/apps/libpiglet")
(new-sise-env-project "sise-env/pigletctl" "~/apps/pigletctl")
