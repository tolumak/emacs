(if (load "haskell-mode" t)
    (setq auto-mode-alist
            (append
               '(("\\.hs\\'" . haskell-mode))
             auto-mode-alist))
)