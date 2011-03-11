;; ORG
(setq org-agenda-files (quote ("~/alstom.org")))
(find-file "~/alstom.org")

;; Backbone EDE projects
(defun backbone-project-hook ()
  (set (make-local-variable 'compile-command) "cd ~/git-nt/backbone/soft ; cd ; . setenv.sh ; cd - ; make -k -j3")
)

(defun new-backbone-project (project_name project_dir style)
  (setq project (new-ede-project project_name project_dir style 'backbone-project-hook))
  (object-add-to-list project :include-path "~/git-nt/backbone/soft/lib/include")
  (if (is-out-of-tree-cedet)
      (add-to-list 'semantic-lex-c-preprocessor-symbol-file "~/git-nt/backbone/soft/linux/include/linux/autoconf.h")
    )
  project
)

(new-backbone-project "backbone/agate_com" "~/git-nt/backbone/soft/agateCom" "ws-4")
(new-backbone-project "backbone/mint" "~/git-nt/backbone/soft/mint" "linux-tabs-only")
(new-backbone-project "backbone/igmp_snooping" "~/git-nt/backbone/soft/igmp_snooping" "gnu")
(new-backbone-project "backbone/liblpc" "~/git-nt/backbone/soft/lib/liblpc" "linux-tabs-only")
(new-backbone-project "backbone/pimd" "~/git-nt/backbone/soft/pimd" "kdelibs")
(new-backbone-project "backbone/topology" "~/git-nt/backbone/soft/Topology_Management" "ws-2")
(new-backbone-project "backbone/libtcoupling" "~/git-nt/backbone/soft/lib/libTcoupling" "linux-tabs-only")
(new-backbone-project "backbone/libdataplug" "~/git-nt/backbone/soft/lib/libDataplug" "ws-4")

;; GDB
(setq gud-gdb-command-name "/opt/eldk/usr/bin/ppc-linux-gdb --annotate=3")

(if nil 
    (

;; Jabber
(require 'jabber)
(setq jabber-account-list '(("michel@cwitc12ubo.dom2.ad.sys")))

;; Gnus
(setq starttls-extra-arguments '("--insecure"))
(setq gnus-secondary-select-methods '((nnimap "gmail"
                                  (nnimap-address "localhost")
                                  (nnimap-server-port 10993)
                                  (nnimap-stream ssl)
)))
(add-to-list 'gnus-secondary-select-methods '(nnimap "maison"
                                  (nnimap-address "localhost")
                                  (nnimap-server-port 10143)))

(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-starttls-credentials '(("localhost" 10587 nil nil))
      smtpmail-auth-credentials '(("localhost" 10587 "michel.lafonpuyo@gmail.com" nil))
      smtpmail-default-smtp-server "localhost"
      smtpmail-smtp-server "localhost"
      smtpmail-smtp-service 10587
      smtpmail-local-domain "mulot.dnsalias.com")
))