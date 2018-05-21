
(setq frame-title-format"Emacs")

(add-to-list 'load-path "~/.emacs.d/evil")
(require 'evil)
(evil-mode 1)

(require 'doom-themes)
(load-theme 'doom-one t)

(doom-themes-visual-bell-config)
(doom-themes-org-config)

(global-nlinum-mode t)

(require 'ido)
(ido-mode t)

(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  ;;(add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  (add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

(electric-pair-mode 1)

(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)

(show-paren-mode)
(setq show-paren-delay 0)

;; attempt to allow emacs tabs to be read in other applciations
;; may or may not do anything
(setq indent-tabs-mode nil)

(fset 'yes-or-no-p 'y-or-n-p)

(setq scroll-step 1)

(setq mouse-wheel-follow-mouse 't)

(require 'flyspell)
(flyspell-mode +1)
;;(add-hook 'text-mode-hook 'flyspell-popup-auto-correct-mode)
(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)

(define-key flyspell-mode-map (kbd "C-,") #'flyspell-popup-correct)
(add-hook 'flyspell-mode-hook #'flyspell-popup-auto-correct-mode)

(global-flycheck-mode)
;; disable elisp
(with-eval-after-load 'flycheck
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc)))

(setq c-basic-offset 4)

(setq c-default-style "linux")

(defun indent-setting ()
  (c-set-offset 'arglist-intro '+))
(add-hook 'java-mode-hook 'indent-setting)

(use-package jedi
  :ensure t
  :init
  (add-hook 'python-mode-hook 'jedi:setup)
  (add-hook 'python-mode-hook 'jedi:ac-setup))

(with-eval-after-load 'python
  (define-key python-mode-map (kbd "C-.") 'jedi:show-doc))

(defun my-verilog-setup ()
    (clear-abbrev-table verilog-mode-abbrev-table))
(add-hook 'verilog-mode-hook #'my-verilog-setup)

(setq verilog-auto-newline nil)

(defun my-vhdl-mode-hook()
  (vhdl-set-style "IEEE")
  )
(add-hook 'vhdl-mode-hook 'my-vhdl-mode-hook)

(setq vhdl-stutter-mode t)

(require 'platformio-mode)

;; Add the required company backend.
(with-eval-after-load 'company
  (add-to-list 'company-backends 'company-irony))

;; Enable irony for all c++ files, and platformio-mode only
;; when needed (platformio.ini present in project root).
(add-hook 'c++-mode-hook (lambda ()
                           (irony-mode)
                           (irony-eldoc)
                           (platformio-conditionally-enable)))

;; Use irony's completion functions.
(add-hook 'irony-mode-hook
          (lambda ()
            (define-key irony-mode-map [remap completion-at-point]
              'irony-completion-at-point-async)

            (define-key irony-mode-map [remap complete-symbol]
              'irony-completion-at-point-async)

            (irony-cdb-autosetup-compile-options)))
            
;; Setup irony for flycheck.
(add-hook 'flycheck-mode-hook 'flycheck-irony-setup)

(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(display-time-mode 1)

(require 'powerline)
(powerline-center-evil-theme)
