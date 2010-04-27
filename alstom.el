
;; Backbone EDE projects
(defun new-backbone-project (project_name project_dir style)
  (setq project (new-ede-project project_name project_dir style))
  (object-add-to-list project :include-path "~/git-nt/backbone/soft/lib/include")
  (add-to-list 'semantic-lex-c-preprocessor-symbol-file "~/git-nt/backbone/soft/linux/include/linux/autoconf.h")
  (setq project project)
)

(new-backbone-project "backbone/agate_com" "~/git-nt/backbone/soft/application/sample" "linux-tabs-only")
(new-backbone-project "backbone/mint" "~/git-nt/backbone/soft/mint" "linux-tabs-only")
(new-backbone-project "backbone/igmp_snooping" "~/git-nt/backbone/soft/igmp_snooping" "linux-tabs-only")
(new-backbone-project "backbone/liblpc" "~/git-nt/backbone/soft/lib/liblpc" "linux-tabs-only")
(new-backbone-project "backbone/libtcoupling" "~/git-nt/backbone/soft/lib/libTcoupling" "linux-tabs-only")

;; GDB
(setq gud-gdb-command-name "/opt/eldk/usr/bin/ppc-linux-gdb --annotate=3")

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
