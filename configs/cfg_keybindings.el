(global-set-key [M-down] 'previous-multiframe-window)
(global-set-key [M-up]   'next-multiframe-window)
;; failes in term char mode unlike M-up
(global-set-key (kbd "M-`") 'next-multiframe-window)

(global-set-key (kbd "M-g") 'goto-line)

;;(global-set-key "\M-?" 'etags-select-find-tag-at-point)
;;(global-set-key "\M-." 'etags-select-find-tag)

;The generic apropos (of any symbol) is MUCH more useful than apropos-command
(global-set-key "\C-ha" 'apropos)

;; ; Vim style keyboard moving
;; (global-set-key (kbd "C-M-l") 'windmove-right)
;; (global-set-key (kbd "C-M-h") 'windmove-left)
;; (global-set-key (kbd "C-M-j") 'windmove-down)
;; (global-set-key (kbd "C-M-k") 'windmove-up)

; Resize windows easily
(global-set-key (kbd "C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "C-<right>") 'enlarage-window-horizontally)
(global-set-key (kbd "C-<up>") 'enlarge-window)
(global-set-key (kbd "C-<down>") 'shrink-window)

;Suspend-frame is stupid
(global-set-key "\C-z" 'ignore)
(global-set-key "\C-x\C-z" 'ignore)

(global-set-key "\C-w" 'backward-kill-word) ;; delete an entire word
(global-set-key "\C-x\C-k" 'kill-region) ;; alternative for old C-w
(global-set-key "\C-c\C-k" 'kill-region) ;; copy for slippery fingers
(global-set-key (kbd "C-;") 'ibuffer)

(use-package comment-dwim-2
  :ensure t
  :bind ("M-;" . comment-dwim-2))

;; (global-set-key "\C-xg" 'magit-status)

;; (global-set-key (kbd "M-[") 'textmate-shift-left)
;; (global-set-key (kbd "M-]") 'textmate-shift-right)
;; (global-set-key (kbd "M-/") 'comment-dwim-2);'comment-or-uncomment-region-or-line)



(defun switch-to-previous-buffer ()
  "Switch to previously open buffer.
Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

(use-package key-chord
  :ensure t
  :demand
  :config
  (key-chord-define-global "jj" 'switch-to-previous-buffer)
  (key-chord-mode +1))

;; Increase/Decrease font size on the fly
;; Taken from: http://is.gd/iaAo
(defun ryan/increase-font-size ()
  (interactive)
  (set-face-attribute 'default
                      nil
                      :height
                      (ceiling (* 1.10
                                  (face-attribute 'default :height)))))
(defun ryan/decrease-font-size ()
  (interactive)
  (set-face-attribute 'default
                      nil
                      :height
                      (floor (* 0.9
                                (face-attribute 'default :height)))))
(global-set-key (kbd "C-+") 'ryan/increase-font-size)
(global-set-key (kbd "C--") 'ryan/decrease-font-size)
