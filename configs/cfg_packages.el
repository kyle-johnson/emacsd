(require 'package)
(setq package-enable-at-startup nil) ;; don't auto-load installed packages
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  (add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
)
(package-initialize)

;; boostrap use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; and make sure it loaded
(eval-when-compile
  (require 'use-package))

;; help out OSX
(when (memq window-system '(mac ns x))
  (progn
    (use-package exec-path-from-shell
      :ensure t
      :demand)
    (exec-path-from-shell-initialize)))
