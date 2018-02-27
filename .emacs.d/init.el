(setq frame-title-format "Emacs Evil Mode")
(package-initialize)

;;Extensions to download:
;;Clone into ~/.emacs.d
;;evil mode: https://github.com/emacs-evil/evil.git 
;;autopair:  https://github.com/joaotavora/autopair.git



;;evil mode
;;evil > emacs >  vim

(add-to-list 'load-path "~/.emacs.d/evil")
(require 'evil)
(evil-mode 1)

;;enable ido mode
(ido-mode)

;;theme
;; (load-theme 'tango-dark)
;;package-install tangotango-theme
(load-theme 'tangotango t)

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


;;Default to 4 spaces for indents
(setq c-default-style "linux" c-basic-offset 4)

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
;;eshell better for most purposes
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

(global-set-key (kbd "C-x C-j") 'c-comment-block-style)

;;highlight matching ([
(show-paren-mode 1)
(setq show-paren-delay 0)

;;disable menu bar
(menu-bar-mode 0)

;;disable the tool bar
(tool-bar-mode 0)

;;diable the scroll bar
(scroll-bar-mode 0)

;;winner-mode
;;undo window changes C-c left redo C-c right
(winner-mode t)

;;chage yes/no prompts to y/n
(fset 'yes-or-no-p 'y-or-n-p)


;;C switch statement style
(c-set-offset 'case-label '+)

;;Write over selected text
(delete-selection-mode 1)

;;Display clock
(display-time-mode 1)


;;MELPA
(require 'package)
(setq package-enable-at-start nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))

(package-initialize)



;powerline-evil
(require 'powerline-evil)
(setq powerline-arrow-shape 'curve)
(setq powerline-default-seperator-dir '(right . left))
(setq sml/theme 'powerline)
;; (setq sml/no-confirm-load-theme t)
;; (setq sml/theme 'dark)
;; (sml/setup)

;;which-key
(which-key-setup-side-window-bottom)
(which-key-mode)

;;magit
(require 'evil-magit)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("84d2f9eeb3f82d619ca4bfffe5f157282f4779732f48a5ac1484d94d5ff5b279" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" default)))
 '(package-selected-packages
   (quote
    (dired-rainbow evil-magit which-key tangotango-theme smart-mode-line-powerline-theme sml-modeline sml-mode smart-mode-line powerline-evil auto-complete auctex))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
