;;evil mode
;;evil > emacs >  vim
;;try spacemacs sometime...
;;Added by Package.el.  This must come before configurations of
;;installed packages.  Don't delete this line.  If you don't want it,
;;just comment it out by adding a semicolon to the start of the line.
;;You may delete these explanatory comments.
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

;;enable tab, emacs :)
(global-set-key (kbd "TAB") 'self-insert-command)


;;Default to 8 spaces for indents
;;Linux style
(setq-default c-basic-offset 8)

;; (setq-default c-basic-offset 4)
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

;;AutoPair
;;Autocomplete (), [], {}, ""
(add-to-list 'load-path "~/.emacs.d/autopair")
(require 'autopair)
(autopair-global-mode)


;;Allow copy and paste from outside
(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)


;;clear shell
(defun clear-shell ()
  (interactive)
  (let ((old-max comint-buffer-maximum-size))
    (setq comint-buffer-maximum-size 0)
    (comint-truncate-buffer)
    (setq comint-buffer-maximum-size old-max)))
;;binding
(global-set-key "\C-f" 'clear-shell)

;;clear eshell
(defun eshell-clear-buffer ()
  "clear terminal"
  (interactive)
  (let ((inhibit-read-only t))
    (erase-buffer)
    (eshell-send-input)))
(add-hook 'eshell-mode-hook
          '(lambda()
             (local-set-key (kbd "C-l") 'eshell-clear-buffer)))

;;hide password, may or may not work
(add-hook 'comint-output-filter-functions 'comint-watch-for-password-prompt)
;;(require 'password-mode)
;;(add-hook 'text-mode-hook 'password-mode)

;;keyboard shortcut for send invisible
(global-set-key (kbd "C-x C-s") 'send-invisible)

;;open shell in same window, emacs25 
(push (cons "\\*shell\\*" display-buffer--same-window-action) display-buffer-alist)





;;Comment blocks with macro
;;Bound to C-x C-j
(defun my-prettify-c-block-comment (orig-fun &rest args)
  (let* ((first-comment-line (looking-back "/\\*\\s-*.*"))
         (star-col-num (when first-comment-line
                         (save-excursion
                           (re-search-backward "/\\*")
                           (1+ (current-column))))))
    (apply orig-fun args)
    (when first-comment-line
      (save-excursion
        (newline)
        (dotimes (cnt star-col-num)
          (insert " "))
        (move-to-column star-col-num)
        (insert "*/"))
      (move-to-column star-col-num) ; comment this line if using bsd style
      (insert "*") ; comment this line if using bsd style
     ))
  ;; Ensure one space between the asterisk and the comment
  (when (not (looking-back " "))
    (insert " ")))
(advice-add 'c-indent-new-comment-line :around #'my-prettify-c-block-comment)
;; (advice-remove 'c-indent-new-comment-line #'my-prettify-c-block-comment)

;;macro
(fset 'c-comment-block-style
   [?/ ?* ?\M-j ?\M-x ?e ?n ?d tab ?m ?a tab])

;;keybind
(global-set-key (kbd "C-x C-j") 'c-comment-block-style)


;;smooth scrolling
(setq scroll-step 1)

;;move temp files somewhere else for the project
(setq backup-directory-alist '(("."."~/.saves")))
