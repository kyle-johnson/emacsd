;; (require 'web-mode)
;; (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.mako\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.jsx?\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.tsx?\\'" . web-mode)) ;; there are probably better options for typescript

;; (setq web-mode-content-types-alist '(("jsx" . "\\.js[x]?\\'")))

;; (add-hook 'web-mode-hook
;;           '(lambda () (progn
;;                    (setq web-mode-markup-indent-offset 2)
;;                    (setq web-mode-code-indent-offset 2)
;;                    (setq web-mode-css-indent-offset 2)
;;                    (setq web-mode-attr-indent-offset 2))))

(use-package web-mode
  :ensure t
  :mode (
         "\\.html?\\'"
         "\\.erb\\'" 
         "\\.php\\'" 
         "\\.mako\\'"
         "\\.jsx?\\'"
         "\\.tsx?\\'"
   )
  :config
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-attr-indent-offset 2)
  (setq web-mode-content-types-alist '(("jsx" . "\\.js[x]?\\'")))
  )

(use-package tern
  :ensure t
  :defer t
  :init
  (add-hook 'web-mode-hook 'tern-mode))

(use-package company-tern
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'company
    (add-to-list 'company-backends 'company-tern)))


;; for prettier and eslint
(defun enable-by-extension (my-pair)
  "Enable minor mode if filename match the regexp. MY-PAIR is a cons cell (regexp . minor-mode|function)."
  (if (buffer-file-name)
      (if (string-match (car my-pair) buffer-file-name)
          (funcall (cdr my-pair)))))

;; need this prettier to figure out where we are
(use-package add-node-modules-path
  :ensure t
  ;;:mode "\\.jsx?\\'"
  :defer t
  :init
  (add-hook 'web-mode-hook 'add-node-modules-path)
  ;; :init
  ;; (eval-after-load 'web-mode
  ;;   '(add-hook 'web-mode-hook
  ;;            #'(lambda () (enable-by-extension '("\\.jsx?\\'" . add-node-modules-path)))))
  )

(use-package prettier-js
  :ensure t
  :defer t
  :init
  (add-hook 'web-mode-hook 'prettier-js-mode)
  (add-hook 'json-mode-hook 'prettier-js-mode)
  )

(use-package json-mode
  :ensure t
  :mode "\\.json\\'")


;;;; Can't used idle-highlight, 'cause it really messes with web-mode's highlighting
;; (add-hook 'web-mode-hook
;;           '(lambda () (idle-highlight)))

;;(require 'sass-mode)
;;(add-hook 'sass-mode-hook
;;          '(lambda () (setq show-trailing-whitespace t)))
;;
;;(require 'css-mode)
;;(add-hook 'css-mode-hook
;;          '(lambda () (setq css-indent-offset 2)))
;;
;;(require 'scss-mode)
;;(add-hook 'scss-mode-hook
;;          ;; disable auto-compile stupidity
;;          '(lambda () (setq scss-compile-at-save nil)))
;;(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))
