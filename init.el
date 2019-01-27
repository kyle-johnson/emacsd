(package-initialize) ;; this is handled for us in cfg_packages

(setq load-path (cons "~/.emacs.d/configs/" load-path))
;; (setq load-path (cons "~/.emacs.d/vendor/" load-path))
(setq load-prefer-newer t)
;;(byte-recompile-directory (expand-file-name "~/.emacs.d") 0)

;; (setenv "PATH" (concat (getenv "PATH") ":~/bin"))
;; (setq exec-path (append exec-path '("~/bin")))

;; slows startup, but gets our NVM and other paths (well, until NVM path changes...)
;;(when (memq window-system '(mac ns x))
;;  (exec-path-from-shell-initialize))

(defconst emacs-config-dir "~/.emacs.d/configs/")
;; (defconst emacs-vendor-dir "~/.emacs.d/vendor/")
(defun get-subdirs (directory)
  "Get a list of subdirectories under a given directory"
  (apply 'nconc (mapcar (lambda (fa)
                        (and
                         (eq (cadr fa) t)
                         (not (equal (car fa) "."))
                         (not (equal (car fa) ".."))
                         (list (car fa))))
                        (directory-files-and-attributes directory))))

(defun add-dirs-to-loadpath (dir-name)
  "add subdirs of your vendor directory to the load path"
  (dolist (subdir (get-subdirs dir-name))
    (setq load-path (cons (concat dir-name subdir) load-path))
    (message "Added %s to load path" subdir)))

;; (add-dirs-to-loadpath emacs-vendor-dir)

(defun load-cfg-files (filelist)
  (dolist (file filelist)
    (let ((filename (expand-file-name (concat emacs-config-dir file ".el"))))
      (if (file-exists-p filename)
          (progn
            (load (concat filename))
            (message "Loaded config file: %s" filename))
      	(message "Could not load file: %s" filename)))))

(load-cfg-files '("cfg_packages"      ;; package management setup
                  "cfg_generic"
                  "cfg_company"       ;; autocomplete!
                  "cfg_ivy"           ;; ido+smex+isearch, it's awesome!
                  "cfg_python"        ;; old, could use help :-)
                  "cfg_golang"        ;; brand spankin' new!
                  "cfg_web"           ;; mostly web-mode.el
                  "cfg_uniquify"      ;; better buffer naming
                  "cfg_keybindings"
                  "cfg_hydras"        ;; contextual help
                  "cfg_color-theme")) ;; set theme

(server-start)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("053e27ddf9398a67f18dfbd046fa785f81d2ee5339cc752d9bbf4917a3d0b40e" "d2622a2a2966905a5237b54f35996ca6fda2f79a9253d44793cfe31079e3c92b" "501caa208affa1145ccbb4b74b6cd66c3091e41c5bb66c677feda9def5eab19c" default)))
 '(desktop-base-file-name "emacs.desktop")
 '(desktop-save t)
 '(global-eldoc-mode nil)
 '(ivy-mode t)
 '(js-indent-level 2)
 '(magit-git-executable "/usr/bin/git")
 '(package-selected-packages
   (quote
    (key-chord web-mode go-eldoc company-go company-quickhelp markdown-mode diminish spaceline powerline company-tern tern go-add-tags flycheck-pos-tip flycheck json-mode hcl-mode go-mode yaml-mode comment-dwim-2 exec-path-from-shell prettier-js add-node-modules-path js2-mode typescript-mode elixir-mode hydra ivy-rich flx use-package counsel ivy)))
 '(paren-match-face (quote paren-face-match-light))
 '(paren-sexp-mode t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :height 110 :family "Menlo"))))
 '(cursor ((t (:background "gray100" :foreground "#F92672"))))
 '(font-lock-type-face ((t (:foreground "#a57705" :underline t))))
 '(idle-highlight ((t (:background "#e6db74" :foreground "#383830"))))
 '(ido-first-match ((t (:background "Blue" :foreground "white"))))
 '(ido-only-match ((((class color)) (:foreground "Blue"))))
 '(mumamo-background-chunk-major ((t nil)))
 '(mumamo-background-chunk-submode1 ((t nil)))
 '(py-object-heirs-face ((t (:slant italic))) t)
 '(region ((t (:background "gray35"))))
 '(show-paren-match ((t (:background "IndianRed1")))))

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'set-goal-column 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(global-eldoc-mode -1)
