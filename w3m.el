(require 'w3m-load)
(setq mm-inline-text-html-renderer 'mm-inline-text-html-render-with-w3m
w3m-display-inline-image t
gnus-article-wash-function 'gnus-article-wash-html-with-w3m)