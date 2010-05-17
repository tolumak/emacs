(when (require 'magit nil t)
  (autoload 'magit-status "magit" nil t)
  (setq magit-omit-untracked-dir-contents t)
  )