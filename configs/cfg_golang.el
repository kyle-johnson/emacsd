(use-package company-go
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'company
    (add-to-list 'company-backends 'company-go))
  )

(use-package go-mode
  :ensure t
  :init
  (progn
    ;; auto-imports ftw
    (setq gofmt-command "goimports")
    (add-hook 'go-mode-hook
              '(lambda () (progn
                       ;; can't stand the huge indents
                       (setq tab-width 2 indent-tabs-mode 1)
                       (local-set-key (kbd "M-.") #'godef-jump)
                       (add-hook 'before-save-hook 'gofmt-before-save)
                       )))
    )
  :config
  (add-hook 'go-mode-hook 'electric-pair-mode)
  ;; :bind ("TAB" . completation-at-point)
  )

(use-package go-eldoc
  :ensure t
  :defer
  :init
  (add-hook 'go-mode-hook 'go-eldoc-setup))

(use-package go-add-tags
  :ensure t
  :defer)
