(use-package company
  :ensure t
  :defer t
  :init (global-company-mode)
  :config
  ;; use company for completion
  ;;(bind-key [remap completion-at-point] #'company-complete company-mode-map)
  (setq company-tooltip-align-annotations t
        ;; Easy navigation to candidates with M-<n>
        company-show-numbers t)
  (setq company-dabbrev-downcase nil)
  ;; TAB to cycle through completions, otherwise use M-n / M-p
  ;; (define-key company-active-map (kbd "TAB") 'company-complete-common-or-cycle)
  ;; (define-key company-active-map (kbd "<tab>")
  ;; 'company-complete-common-or-cycle)
  :bind ("C-M-i" . company-complete)
  )

;; supposed to be able to M-h to show help, but that doesn't work, soooo
(use-package company-quickhelp          ; Documentation popups for Company
  :ensure t
  :defer t
  :init
  (add-hook 'global-company-mode-hook #'company-quickhelp-mode)
  (setq company-quickhelp-delay nil)
  )
