(if (load "haskell-mode")
    (setq auto-mode-alist
            (append
               '(("\\.hs\\'" . haskell-mode))
             auto-mode-alist))
)