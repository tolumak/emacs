;;;;;;;;;;;;;;;;;;;;;;;;
;;; gnus
;;;;;;;;;;;;;;;;;;;;;;;;
(setq gnus-select-method '(nnml ""))

(setq gnus-secondary-select-methods '((nnimap "gmail"
                                  (nnimap-address "imap.gmail.com")
                                  (nnimap-server-port 993)
                                  (nnimap-stream ssl)
)))
(add-to-list 'gnus-secondary-select-methods '(nnimap "maison"
                                  (nnimap-address "78.227.44.252")
                                  (nnimap-server-port 143)))

(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
      smtpmail-auth-credentials '(("smtp.gmail.com" 587 "michel.lafonpuyo@gmail.com" nil))
      smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587
      smtpmail-local-domain "mulot.dnsalias.com")
