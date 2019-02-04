(use-package go-mode
  :ensure t
  :init
  (progn
    (add-hook 'go-mode-hook
              '(lambda () (progn
                       ;; can't stand the huge indents
                       (setq tab-width 2 indent-tabs-mode 1)
                       (local-set-key (kbd "M-.") #'godef-jump)
                       (add-hook 'before-save-hook 'gofmt-before-save)
                       (flycheck-mode)
                       )))
    )
  ;; :hook
  ;; ((before-save . gofmt-before-save)
  ;;  (go-mode . electric-pair-mode)
  ;;  (go-mode . (lambda ()
  ;;               (setq tab-width 2 indent-tabs-mode 1)
  ;;               (local-set-key (kbd "M-.") #'godef-jump)
  ;;               (set (make-local-variable 'company-backends) '(company-go))
  ;;               ;; (company-mode)
  ;;               (flycheck-mode)))
  ;;  )
  :config
  (setq gofmt-command "goimports")    ;; auto-imports ftw
  (add-hook 'go-mode-hook 'electric-pair-mode)
  ;; :bind ("TAB" . completation-at-point)
  )

;; (use-package company-go
;;   :ensure t
;;   ;; :config
;;   ;; (setq tab-width 2)
;;   ;; (setq company-begin-commands '(self-insert-command))
;;   :config
;;   (with-eval-after-load 'company
;;     (add-to-list 'company-backends 'company-go))
;;   (setq company-tooltip-limit 20)
;;   (setq company-idle-delay .3)
;;   (setq company-echo-delay 0)
;;   )


;; (use-package go-eldoc
;;   :ensure t
;;   :hook
;;   (go-mode . go-eldoc-setup))

(use-package go-direx
  :ensure t
  :pin melpa-stable
  :defer t
  :bind (:map go-mode-map
              ("C-c C-t" . go-direx-pop-to-buffer ))
  :init
  (push '("^\*go-direx:" :regexp t :align left :size 0.25) shackle-rules)
  :config
  (shackle-mode t)
  ;;(setq display-buffer-function 'popwin:display-buffer)
  ;; (setq popwin:special-display-config '("^\*go-direx:" :regexp t :position left :width 0.4 :dedicated t :stick t))
  )

;; convience command for adding tags to structs
(use-package go-add-tags
  :ensure t
  :defer)

;; (use-package flycheck-gometalinter
;;   :ensure t
;;   :init
;;   ;; skip linting for vendor dirs
;;   (setq flycheck-gometalinter-vendor t)
;;   ;; only show errors
;;   (setq flycheck-gometalinter-errors-only t)
;;   ;; only run fast linters
;;   (setq flycheck-gometalinter-fast t)
;;   ;; default is 5s
;;   (setq flycheck-gometalinter-deadline "15s")
;;   ;; not everything works with gomodules yet
;;   ;; gotype iwould be suuuuper nice, watch this (VSCode folks are ignoring it): https://github.com/golang/go/issues/24661
;;   (setq flycheck-gometalinter-disable-linters '("gotype" "gocyclo" "maligned" "dupl" "interfacer"))
;;   :config
;;   (flycheck-gometalinter-setup))

(use-package flycheck-golangci-lint
  :ensure t
  :hook (go-mode . flycheck-golangci-lint-setup)
  :config
  (setq flycheck-golangci-lint-fast t))
