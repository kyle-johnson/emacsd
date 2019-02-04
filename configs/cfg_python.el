;;; python-mode site-lisp configuration
(require 'python)

(add-hook 'python-mode-hook
          '(lambda () (progn
                   (set-variable 'python-indent-offset 4)
                   (set-variable 'default-tab-width 4)
                   (local-set-key (kbd "M-[") 'python-indent-shift-left)
                   (local-set-key (kbd "M-]") 'python-indent-shift-right)
                   )))

;; hide the anying *.egg-info dirs from setup.py develop
(setq completion-ignored-extensions
      (cons ".egg-info/" completion-ignored-extensions))

;; virtualenv support
;(require 'virtualenv)

;;(setq pdb-path '/usr/bin/pdb
;;      gud-pdb-command-name (symbol-name pdb-path))

;; when running pdb, prepopulate the current buffer's name
;;(defadvice pdb (before gud-query-cmdline activate)
;;  "Provide a better default command line when called interactively."
;;  (interactive
;;   (list (gud-query-cmdline pdb-path
;;			    (file-name-nondirectory buffer-file-name)))))


;; (add-hook 'python-mode-hook
          ;; '(lambda () (setq ac-omni-completion-sources '(("\\." ac-source-ropemacs)))))

;; (add-hook 'python-mode-hook
          ;; '(lambda () (add-to-list 'ac-sources 'ac-source-ropemacs)))

;;(add-hook 'python-mode-hook
;;          '(lambda () (eldoc-mode 1)) t)
;; (add-hook 'python-mode-hook
;;           '(lambda () (highlight-80+-mode 1)) t)

;; idle highlight ftw!
(use-package idle-highlight-mode
  :ensure t
  :hook (python-mode-hoook . idle-highlight-mode))


;; trailing whitespace sucks
(add-hook 'python-mode-hook
          '(lambda () (setq show-trailing-whitespace t)))

; (add-hook 'python-mode-hook
;           '(lambda () (progn
;                    (defvar py-object-heirs-face 'py-object-heirs-face
;                      "Face for object inherieted from")
;                    (make-face 'py-object-heirs-face)
;                    (font-lock-add-keywords
;                     nil
;                     '(("\\class[ \t]+[a-zA-Z_]+[a-zA-Z0-9_]*\(\\(.*\\)\)"
;                        1 py-object-heirs-face))))))

; (add-hook 'python-mode-hook
;           '(lambda () (progn
;                    (defvar py-named-keyword-face 'py-named-keyword-face
;                      "Face for keyword arguments")
;                    (make-face 'py-named-keyword-face)
;                    (font-lock-add-keywords
;                     nil
;                     '(("\\([a-zA-Z_]+[a-zA-Z0-9_]*\\)=[a-zA-Z0-9_\"'{\[(]"
;                        1 py-named-keyword-face))))))


;(setq jedi:server-args
;      '("--virtualenv" "/Users/kylejohnson/.virtualenvs/nlg"))
;
;(autoload 'jedi:setup "jedi" nil t)
;(add-hook 'python-mode-hook 'jedi:setup)
;(add-hook 'python-mode-hook
;          '(lambda ()
;             (progn
;               (local-set-key (kbd "C-.") 'jedi:goto-definition))))


; python doc search
;;(defun py-doc-search (w)
;;  "Launch PyDOC on the Word at Point"
;;  (interactive
;;   (list (let* ((word (thing-at-point 'word))
;;                (input (read-string 
;;                        (format "pydoc entry%s: " 
;;                                (if (not word) "" (format " (default %s)" word))))))
;;           (if (string= input "") 
;;               (if (not word) (error "No pydoc args given")
;;                 word)                  ;sinon word
;;             input))))                  ;sinon input
;;  (shell-command (concat py-python-command " -c \"from pydoc import help;help(\'" w "\')\"") "*PYDOCS*")
;;  (view-buffer-other-window "*PYDOCS*" t 'kill-buffer-and-window))
;;
;;(add-hook 'python-mode-hook
;;          (lambda ()
;;            (progn
;;                (local-set-key "\C-c\C-f" 'py-doc-search)
;;                (local-set-key "\M-\C-h" 'windmove-left))))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Auto Syntax Error Hightlight

;; (when (load "flymake" t)
;;   (defun flymake-pyflakes-init ()
;;     (let* ((temp-file (flymake-init-create-temp-buffer-copy
;;                        'flymake-create-temp-inplace))
;;        (local-file (file-relative-name
;;                     temp-file
;;                     (file-name-directory buffer-file-name))))
;;       (list "/usr/local/bin/pyflakes" (list local-file))))
;;   (add-to-list 'flymake-allowed-file-name-masks
;;                '("\\.py\\'" flymake-pyflakes-init)))
;; (add-hook 'find-file-hook 'flymake-find-file-hook)


;; pymacs
;; (autoload 'pymacs-apply "pymacs")
;; (autoload 'pymacs-call "pymacs")
;; (autoload 'pymacs-eval "pymacs" nil t)
;; (autoload 'pymacs-exec "pymacs" nil t)
;; (autoload 'pymacs-load "pymacs" nil t)
;; (autoload 'pymacs-autoload "pymacs")

;; rope
;; (defun load-ropemacs ()
;;   "Load pymacs and ropemacs"
;;   (interactive)
;;   (require 'pymacs)
;;   (setq reopmacs-enable-shortcuts nil)
;;   (setq ropemacs-local-prefix "C-c C-p")
;;   (pymacs-load "ropemacs" "rope-")
;;   ;; auto save project python buffers before refactorings
;;   (setq ropemacs-enable-autoimport t)
;; )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Auto-completion
;;; Integrates:
;;; 1) Rope
;;; 2) Yasnippet
;;; all with AutoComplete.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;(defun prefix-list-elements (list prefix)
;;  (let (value)
;;    (nreverse
;;     (dolist (element list value)
;;       (setq value (cons (format "%s%s" prefix element) value))))))
;;(defvar ac-source-rope
;;  '((candidates
;;     . (lambda ()
;;         (prefix-list-elements (rope-completions) ac-target))))
;;  "Source for Rope")
;;(defun ac-python-find ()
;;  "Python `ac-find-function'."
;;  (require 'thingatpt)
;;  (let ((symbol (car-safe (bounds-of-thing-at-point 'symbol))))
;;    (if (null symbol)
;;        (if (string= "." (buffer-substring (- (point) 1) (point)))
;;            (point)
;;          nil)
;;      symbol)))
;;(defun ac-python-candidate ()
;;  "Python `ac-candidates-function'"
;;  (let (candidates)
;;    (dolist (source ac-sources)
;;      (if (symbolp source)
;;          (setq source (symbol-value source)))
;;      (let* ((ac-limit (or (cdr-safe (assq 'limit source)) ac-limit))
;;             (requires (cdr-safe (assq 'requires source)))
;;             cand)
;;        (if (or (null requires)
;;                (>= (length ac-target) requires))
;;            (setq cand
;;                  (delq nil
;;                        (mapcar (lambda (candidate)
;;                                  (propertize candidate 'source source))
;;                                (funcall (cdr (assq 'candidates source)))))))
;;        (if (and (> ac-limit 1)
;;                 (> (length cand) ac-limit))
;;            (setcdr (nthcdr (1- ac-limit) cand) nil))
;;        (setq candidates (append candidates cand))))
;;    (delete-dups candidates)))
;;(add-hook 'python-mode-hook
;;          (lambda ()
;;            (auto-complete-mode 1)
;;            (set (make-local-variable 'ac-sources)
;;                 (append ac-sources '(ac-source-rope) '(ac-source-yasnippet)))
;;            (set (make-local-variable 'ac-find-function) 'ac-python-find)
;;            (set (make-local-variable 'ac-candidate-function) 'ac-python-candidate)
;;            (set (make-local-variable 'ac-auto-start) nil)))

;;Ryan's python specific tab completion
;;(defun ryan-python-tab ()
;;  ; Try the following:
;;  ; 1) Do a yasnippet expansion
;;  ; 2) Do a Rope code completion
;;  ; 3) Do an indent
;;  (interactive)
;;  (if (eql (ac-start) 0)
;;      (indent-for-tab-command)))
;;(defadvice ac-start (before advice-turn-on-auto-start activate)
;;  (set (make-local-variable 'ac-auto-start) t))
;;(defadvice ac-cleanup (after advice-turn-off-auto-start activate)
;;  (set (make-local-variable 'ac-auto-start) nil))
;;(define-key py-mode-map (kbd "TAB") 'ryan-python-tab)


;; (global-set-key (kbd "ESC M-p") 'rope-open-project)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; End Auto Completion
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; (defun my-compile ()
;   "Use compile to run python programs"
;   (interactive)
;   (compile (concat "python " (buffer-name))))
; (setq compilation-scroll-output t)


; (local-set-key "\C-c\C-p" 'my-compile)


;;(require 'comint)
;;(define-key comint-mode-map [(meta p)]
;;  'comint-previous-matching-input-from-input)
;;(define-key comint-mode-map [(meta n)]
;;  'comint-next-matching-input-from-input)
;;(define-key comint-mode-map [(control meta n)]
;;  'comint-next-input)
;;(define-key comint-mode-map [(control meta p)]
;;  'comint-previous-input)


;;(setq py-python-command-args '("-pylab" "-colors" "Linux"))

;;(defadvice py-execute-buffer (around python-keep-focus activate)
;;  (let ((remember-window (selected-window))
;;        (remember-point (point)))
;;    ad-do-it
;;    (select-window remember-window)
;;    (goto-char remember-point)))
;;
;;(defun rgr/python-execute()
;;  (interactive)
;;  (if mark-active
;;      (py-execute-string (buffer-substring-no-properties (region-beginning) (region-end)))
;;    (py-execute-buffer)))
;;(global-set-key (kbd "C-c C-e") 'rgr/python-execute)
;;
;;(setq auto-mode-alist
;;      (append '(("\\.txt$" . rst-mode)
;;                ("\\.rst$" . rst-mode)
;;                ("\\.rest$" . rst-mode)) auto-mode-alist))
