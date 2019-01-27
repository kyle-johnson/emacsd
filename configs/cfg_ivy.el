(use-package counsel
  :demand
  :ensure t)

(use-package ivy
  :demand
  :ensure t
  :config
  (global-set-key (kbd "C-s") 'swiper)
  (global-set-key (kbd "M-x") 'counsel-M-x)
  (global-set-key (kbd "C-x C-f") 'counsel-find-file)
  ;;(global-set-key (kbd "C-c k") 'counsel-ag)
  (setq ivy-use-virtual-buffers t
        ivy-count-format "%d/%d "
        enable-recursive-minibuffers t)
  (ivy-mode 1)
  ;; configure regexp engine.
  (setq ivy-re-builders-alist
        ;; allow input not in order
        '((t   . ivy--regex-ignore-order)))
  )

(use-package swiper
  :ensure t
  :demand
  :after ivy)

(use-package ivy-rich
  :ensure t
  :after counsel
  :init     (setq ivy-virtual-abbreviate 'full
                  ivy-rich-switch-buffer-align-virtual-buffer t
                  ivy-rich-path-style 'abbrev)
  :config
  (ivy-rich-mode)
  )


;;(ivy-mode 1)
;;(setq ivy-use-virtual-buffers t)
;;(setq ivy-count-format "(%d/%d) ")
;;(setq ivy-re-builders-alist
;;      '((t . ivy--regex-fuzzy)))

;;(ivy-set-display-transformer 'ivy-switch-buffer 'ivy-rich-switch-buffer-transformer)
;; (setq ivy-rich-path-style 'abbrev)



;;(global-set-key (kbd "C-x b") 'ivy-switch-buffer)

;; (global-set-key (kbd "<f1> f") 'counsel-describe-function)
;; (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
;; (global-set-key (kbd "<f1> l") 'counsel-find-library)
;; (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
;; (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
