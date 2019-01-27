;; Color Theme 

;; (add-to-list 'custom-theme-load-path "~/.emacs.d/themes/solarized24")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/monokai")

(load-theme 'monokai t)

(set-face-attribute 'mode-line nil
                    :box nil)
(set-face-attribute 'mode-line-inactive nil
                    :box nil)

