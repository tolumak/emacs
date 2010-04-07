(require 'w3m-load)
(setq mm-inline-text-html-renderer 'mm-inline-text-html-render-with-w3m
w3m-display-inline-images t
gnus-article-wash-function 'gnus-article-wash-html-with-w3m)

(setq mm-w3m-safe-url-regexp nil)
(setq w3m-default-display-inline-images t)
(setq w3m-toggle-inline-images-permanently t)


