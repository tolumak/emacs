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

(defconst sise-linux-qt-style
  '("linux"
    (c-offsets-alist
;;     (topmost-intro-cont . qt-lineup-topmost-intro-cont)
 ;;    (inher-cont . qt-lineup-inher-cont)
     )
    )
  "sise-linux-qt")


(c-add-style "rmz" rmz-style)
(c-add-style "sise-linux-qt" sise-linux-qt-style)

(defcustom sise-linux-target nil "SISE Linux environment target")
(defcustom sise-linux-compile-args "-j3 D=1 install" "SISE Linux environment compile flags")
(defcustom sise-linux-target-ip nil "SISE Linux target IP address")


(defun ask-for-target (target)
  (interactive "MPlease specify the SISE Linux target: ")
  (setq sise-linux-target target)
)

(defun ask-for-target-ip (target-ip)
  (interactive "MPlease specify the SISE Linux target IP address: ")
  (setq sise-linux-target-ip target-ip)
)

(defun sise-project-hook ()
)

(defun new-sise-project (project_name project_dir style)
  (setq project (new-ede-project project_name project_dir style 'sise-project-hook))
  project
)

(defun copy-and-start ()
  (interactive)
  (unless sise-linux-target-ip
    (call-interactively 'ask-for-target-ip)
    )
  (compile (format "target=`echo %s | sed 's#_#/#'` ip=%s; cd ~/sise-linux/devenv/ ; . scripts/setenv.sh %s ; find ~/sise-linux/devenv/$target/debug/usr -type f -executable -exec $TOOLCHAIN_PATH/bin/$TOOLCHAIN_PREFIX-strip -s '{}' \\\;  ; ssh root@$ip '/etc/init.d/S41guim stop ; /etc/init.d/S31controld stop ; /etc/init.d/S31udevmond stop' ; sleep 2 ; scp -r ~/sise-linux/devenv/$target/debug/usr root@$ip:/ ; ssh root@$ip '/etc/init.d/S31controld start ; /etc/init.d/S31udevmond start ; /etc/init.d/S41guim start'" sise-linux-target sise-linux-target-ip sise-linux-target))
)

(defun sise-linux-compile ()
  (interactive)
  (compile (format "cd ~/sise-linux/devenv/ ; . build.sh %s %s" sise-linux-target sise-linux-compile-args))
)

(defun sise-linux-project-hook ()
  (unless sise-linux-target
    (call-interactively 'ask-for-target)
    )
  (local-set-key [f4] 'copy-and-start)
  (local-set-key [f5] 'sise-linux-compile)
)


(defun new-sise-linux-project (project_name project_dir)
  (setq project (new-ede-project project_name project_dir "linux-tabs-only" 'sise-linux-project-hook))
  (object-add-to-list project :include-path (format "~/targets/%s/sysroot/usr/include" sise-linux-target))
  (object-add-to-list project :include-path (format "~/targets/%s/sysroot/usr/include/dbus-1.0" sise-linux-target))
  (object-add-to-list project :include-path (format "~/targets/%s/sysroot/usr/lib/dbus-1.0/include" sise-linux-target))
  project
)

(defun new-sise-linux-qt-project (project_name project_dir)
  (setq qt4-base-dir "~/sise-linux/devenv/sysroot/usr/include/")
  (setq project (new-qt4-project project_name project_dir "sise-linux-qt" 'sise-linux-project-hook))
  (object-add-to-list project :include-path (format "~/targets/%s/sysroot/usr/include" sise-linux-target))
  (object-add-to-list project :include-path (format "~/targets/%s/sysroot/usr/include/dbus-1.0" sise-linux-target))
  (object-add-to-list project :include-path (format "~/targets/%s/sysroot/usr/lib/dbus-1.0/include" sise-linux-target))
  project
)

(new-sise-project "rmz" "~/RMZ" "rmz")
(new-sise-linux-project "sise-linux/libcdbus" "~/apps/libcdbus")
(new-sise-linux-project "sise-linux/libcdbus" "~/apps/moddump")
(new-sise-linux-qt-project "sise-linux/libqtsise" "~/apps/libqtsise")
(new-sise-linux-qt-project "sise-linux/guim" "~/apps/guim")
(new-sise-linux-qt-project "sise-linux/mv2cfg" "~/apps/mv2cfg")
(new-sise-linux-qt-project "sise-linux/plotplot" "~/apps/plotplot")
(new-sise-linux-project "sise-linux/controld" "~/apps/controld")
(new-sise-linux-project "sise-linux/udevmond" "~/apps/udevmond")
(new-sise-linux-project "sise-linux/libsiseconfig" "~/apps/libsiseconfig")
(new-sise-linux-project "sise-linux/libtchoutchou" "~/apps/libtchoutchou")
