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


(setq gnus-novice-user nil)


;; RSS
;; -*- coding: utf-8-emacs; -*-
(setq nnrss-group-alist '(("KDE-Look.org Content" "http://www.kde.org/kde-look-content.rdf" "KDE-Look.org: Eyecandy for your KDE-Desktop") ("KDE-Apps.org Content" "http://www.kde.org/dot/kde-apps-content.rdf" "KDE-Look.org: Applications for your KDE-Desktop") ("Planet KDE" "http://planetkde.org/rss20.xml" "Planet KDE - http://planetKDE.org/") ("KDE.news" "http://www.kde.org/dotkdeorg.rdf" "") ("Arch Linux: Recent news updates" "http://www.archlinux.org/feeds/news/" "The latest and greatest news from the Arch Linux distribution.") ("Arch Linux: Recent package updates" "http://www.archlinux.org/feeds/packages/" "Recently updated packages in the Arch Linux package repositories.") ("Dilbert Daily Strip" "http://feeds.dilbert.com/DilbertDailyStrip?format=xml" "The Official Dilbert Daily Comic Strip RSS Feed")))
(setq nnrss-server-data '(("KDE-Look.org Content" 20) ("KDE-Apps.org Content" 20) ("Planet KDE" 30) ("KDE.news" 10) ("Arch Linux: Recent news updates" 10) ("Arch Linux: Recent package updates" 50) ("Dilbert Daily Strip" 7)))