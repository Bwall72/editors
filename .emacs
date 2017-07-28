;;evil mode
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
