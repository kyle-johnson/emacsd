;; alter default behavior
(prefer-coding-system 'utf-8) ;; use utf-8

(setq user-temporary-file-directory "/tmp/")
(require 'saveplace)

(setq-default fill-column 79)

;; get OSX to open a file in the window its dropped on,
;; not just copy the contents
(setq ns-pop-up-frames nil)

;; hide dumb OSX meta-data files
(setq completion-ignored-extensions
      (cons ".DS_Store" completion-ignored-extensions))

(setq
 vc-handled-backends nil
 ispell-program-name "/usr/local/bin/aspell"
 ispell-extra-args '("--sug-mode=ultra")
 backup-by-copying t ;; fix for Transmitt to work
 backup-by-copying-when-linked t ;; preserve hard links
 backup-by-copying-when-mismatch t ;; preserve owner:group
 frame-title-format '(buffer-file-name "%f" ("%b")) ;; titlebar = buffer unless filename
 column-number-mode t
 transient-mark-mode t ;; show selections
 indicate-empty-lines t
 history-length t ;; infinite history
 color-theme-is-global t
;; magit-auto-update t
;; magit-collapse-threshold nil
 save-place-file (concat user-temporary-file-directory "saveplace") ;; keep my ~/ clean
 truncate-partial-width-windows nil
 set-mark-command-repeat-pop t ; Mark-ring is navigable by typing C-u C-SPC and then repeating C-SPC forever
 auto-save-list-file-prefix (concat user-temporary-file-directory ".auto-saves-")
 auto-save-file-name-transforms `((".*" ,user-temporary-file-directory t))
 inhibit-startup-message t ;; no splash screen
 show-trailing-whitespace t ;; show when there is excess space
 user-mail-address "kyle@kyleemail.com"
 version-control t ;; user numbers for backups
 delete-old-versions t ;; silently delete extra backup versions
 default-tab-width 4 ;; a tab is 4 spaces
 ;; ido-default-file-method 'selected-window
 ;; ido-default-buffer-method ' selected-window
 ;; ido-save-directory-list-file "~/.emacs.d/ido.last"
 ;; ido-use-filename-at-point t
 ;; ido-use-url-at-point t
 ;; browse-url-generic-program "google-chrome"
 ;; browse-url-browser-function 'browse-url-generic
 multi-term-program "/bin/bash")

;; (menu-bar-mode -1)
(tool-bar-mode -1) ;; hide the excess chrome
(scroll-bar-mode -1) ;; hide scroll bars (there are better options than OSX's native bars if needed)
(show-paren-mode +1) ;; show paired parenthasis
(delete-selection-mode +1) ;; delete words if they are selected and you start typing
(auto-compression-mode +1) ;; auto compress/decompress files
(line-number-mode +1)
(auto-fill-mode +1)
(global-linum-mode +1) ;; give me some line numbers
(icomplete-mode +1) ;; incremental minibuffer completion
(global-font-lock-mode +1) ;; make pretty fonts?
(when (fboundp 'shell-command-completion-mode)
  (shell-command-completion-mode +1))
(when (fboundp 'savehist-mode)
  (savehist-mode +1))
;; (mapc (lambda (x)
;;         (add-hook x 'turn-on-eldoc-mode))
;;       ;; A major mode supports eldoc iff it defines
;;       ;; `eldoc-documentation-function'.
;;       '(emacs-lisp-mode-hook ielm-mode-hook))
(mapc (lambda (major-mode) ; Similar to http://emacswiki.org/wiki/PrettyLambda
        (font-lock-add-keywords major-mode
                                `(("(\\(lambda\\)\\>"
                                   (0 (prog1 ()
                                        (compose-region (match-beginning 1)
                                                        (match-end 1)
                                                        ,(make-char 'greek-iso8859-7 107))))))))
      '(emacs-lisp-mode
        inferior-emacs-lisp-mode
        lisp-mode
        slime-repl-mode
        inferior-lisp-mode
        scheme-mode
        scheme48-mode
        inferior-scheme-mode))
(when (fboundp 'ibuffer)
  (global-set-key (kbd "C-x C-b") 'ibuffer))
;; (when (fboundp 'org-mode)
;;   (add-to-list 'auto-mode-alist '("/TODO\\'" . org-mode)))
;; (when (fboundp 'markdown-mode)
;;   (add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode)))

;; keep an empty scratch buffer around on load
(autoload 'scratch "scratch" nil t)

(setq mac-command-modifier 'meta)

(setq-default
 ;; org-log-done "note" ;; prompt for an org note when marking things as done
 truncate-lines nil ;; truncate lines, not wrap
 save-place t ;; enable save-place globally by default
 indent-tabs-mode nil) ;; indent via spaces not tabs

(global-subword-mode 1) ;; easily navigate funny cased words
(set-default 'sentence-end-double-space nil) ;; who does that anymore??

(toggle-debug-on-error nil) ;; show traceback on error
(fset 'yes-or-no-p 'y-or-n-p) ;; allows you to type "y" instead of "yes" on exit

(mouse-avoidance-mode 'cat-and-mouse) ;; mouse jumps away when typing under it
(if (load "mwheel" t)
    (mwheel-install)) ;; turn on the mouse wheel

;; enable windmove if the package is available
;; (when (fboundp 'windmove-default-keybindings)
;;   (windmove-default-keybindings))

;; stop leaving # files and ~ files strewn about. put them in a temp folder
(defvar user-temporary-file-directory
  (concat temporary-file-directory user-login-name "/"))
(make-directory user-temporary-file-directory t)
(defconst use-backup-dir t)
(setq backup-directory-alist
      `(("." . ,user-temporary-file-directory)
        (,tramp-file-name-regexp nil)))
(setq create-lockfiles nil) ; stop with the #xyz files which mess with some tools

;;(require 'rst) ;; require ReST mode
;;(require 'textmate) ;; defunkt's textmate.el
;;(textmate-mode)

(winner-mode t) ;; turn on saved buffer configs

;; we like these
;;(require 'smooth-scrolling) ;; stop text from jumping on scroll.
;;(require 'idle-highlight) ;; highlight word on pause

;; (require 'command-log-mode) ;; useful to demo emacs functionality

;;(require 'flymake-cursor)
;;(setq flymake-gui-warnings-enabled nil)

;; (require 'magit)

;; (require 'titlecase) ;; useful, needs a perl script

;; edit remote files? yes please!
(require 'tramp)
(setq tramp-default-method "ssh")


;; better status bar (Get this)
;; (use-package powerline
;;   :ensure t
;;   :config
;;   (setq powerline-arrow-shape 'arrow14)
;;   (powerline-default-theme))

;; (use-package spaceline
;;   :ensure t
;;   :pin melpa-stable)
;; (use-package spaceline-config
;;   :ensure spaceline)

;; (use-package all-the-icons
;;   :ensure
;;   :defer t)

;; (use-package spaceline-all-the-icons
;;   :ensure
;;   :pin melpa-stable
;;   :after spaceline
;;   :config (spaceline-all-the-icons-theme))

;Reload .emacs on the fly
(defun reload-dot-emacs()
  (interactive)
  (if(bufferp (get-file-buffer ".emacs"))
      (save-buffer(get-buffer ".emacs")))
  (load-file "~/.emacs.d/init.el")
  (message ".emacs reloaded successfully"))

(setq initial-frame-alist '((top . 1)
                            (left . 1)
                            (width . 100)
                            (height . 45)))

;;(defun fixme ()
;;  (interactive)
;;  (find-grep "find . -type f -exec grep -nH -e \"\\(FIXME\\|TODO\\)\" {} /dev/null \\;"))

;; MISC CRAP
(defalias 'qrr 'query-replace-regexp)

;; this also effects PHP
(setq c-default-style "bsd"
      c-basic-offset 4)

(defun revert-all-buffers ()
  "Refreshes all open buffers from their respective files."
  (interactive)
  (dolist (buf (buffer-list))
    (with-current-buffer buf
      (when (and (buffer-file-name) (not (buffer-modified-p)))
        (revert-buffer t t t) )))
  (message "Refreshed open files."))


;;;;;;;;;;;;;;;;;;;;;;;;;
;; new packages

(use-package pos-tip
  :ensure t
  :defer t)

(use-package flycheck
  :ensure t
  :init
  (add-hook 'web-mode-hook 'flycheck-mode)
  :config
  ;; disable json-jsonlist checking for json files
  ;; disable jshint since we prefer eslint checking
  (setq-default flycheck-emacs-lisp-initialize-packages t
                flycheck-disabled-checkers '(json-jsonlist javascript-jshint handlebars))

  ;; Fixups
  ;; use eslint with web-mode for js/jsx files
  (flycheck-add-mode 'javascript-eslint 'web-mode)
  ;; (let ((old-enabled (flycheck-checker-get 'javascript-eslint 'enabled)))
  ;;   (setf (flycheck-checker-get 'javascript-eslint 'enabled)
  ;;         (lambda ()
  ;;           (and
  ;;            (string-match-p "\\.js" buffer-file-name)
  ;;            (funcall old-enabled)))))

  ;; Workaround for eslint loading slow
  ;; https://github.com/flycheck/flycheck/issues/1129#issuecomment-319600923
  (advice-add 'flycheck-eslint-config-exists-p :override (lambda() t))

  ;; stuff error window at bottom
  (add-to-list 'display-buffer-alist
             `(,(rx bos "*Flycheck errors*" eos)
              (display-buffer-reuse-window
               display-buffer-in-side-window)
              (side            . bottom)
              (reusable-frames . visible)
              (window-height   . 0.33)))
  )

(use-package flycheck-pos-tip
  :ensure t
  :defer t
  :config
  (with-eval-after-load 'flycheck (flycheck-pos-tip-mode)))

(use-package diminish
  :ensure t
  :defer t)

(use-package hcl-mode
  :ensure t
  :mode "\\.tf\\'")

(use-package markdown-mode
  :ensure t
  :mode "\\.md\\'")

(use-package direx
  :ensure t
  :defer t)

(use-package shackle
  :ensure t)

(use-package yaml-mode
  :ensure t
  :mode (
   "\\.yml\\'"
   "\\.yaml\\'"
  ))
