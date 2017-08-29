;;evil mode

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/evil")
(require 'evil)
(evil-mode 1)

;;theme
(load-theme 'tango-dark)

;;line numbers
(global-linum-mode t)

;;prevent shell text from being deleted
(setq comint-prompt-read-only t)

;;up and down arrow in shell
(progn(require 'comint)
(define-key comint-mode-map (kbd "<up>") 'comint-previous-input)
(define-key comint-mode-map (kbd "<down>") 'comint-next-input))

;;enable tab
(global-set-key (kbd "TAB") 'self-insert-command)

;;tab width
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

;;enable shift tab
(global-set-key (kbd "<backtab>") 'un-indent-by-removing-4-spaces)
(defun un-indent-by-removing-4-spaces ()
  "remove 4 spaces from beginning of line"
  (interactive)
  (save-excursion
    (save-match-data
      (beginning-of-line)
      ;;get rid of tabs at beginning of line
      (when (looking-at "^\\s-+")
	(untabify (match-beginning 0) (match-end 0)))
   (when (looking-at "^    ")
      (replace-match "")))))

;;clear shell
(defun eshell-clear-buffer ()
  "clear terminal"
  (interactive)
  (let ((inhibit-read-only t))
    (erase-buffer)
    (eshell-send-input)))
(add-hook 'eshell-mode-hook
          '(lambda()
             (local-set-key (kbd "C-l") 'eshell-clear-buffer)))
;;AutoPair
(add-to-list 'load-path "~/autopair")
(require 'autopair)
(autopair-global-mode)

;;Matlab
(autoload 'matlab-mode "matlab" "Matlab Editing Mode" t)
(add-to-list
 'auto-mode-alist
 '("\\.m$" . matlab-mode))
(setq matlab-indent-function t)
(setq matlab-shell-command "matlab")
(custom-set-variables


 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (auctex))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
