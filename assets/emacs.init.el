(require 'calfw-org)
(require 'fira-code-mode)
(require 'lsp-haskell)
(require 'lsp-mode)
(require 'mu4e)
(require 'nix-mode)
(require 'org-superstar)
(require 'package)

(defun all-the-fancy-things ()
  (flycheck-mode) (lsp) (company-mode))

(defun make-a-vector (list)
  (vconcat '() list))

;; This is some slight witchcraft to determine whether or not some
;; text is written in Fira. We need to know this to determine whether
;; or not to apply ligatures.
(defun is-fira (pos)
  (let ((font (font-at pos)))
    (if (not font) nil
      (let ((family (font-get font :family)))
	(if (not family) nil
	  (or (string= "Fira Code" family)
	      (string= "FiraCode"  family)))))))

;;; Keybindings

(defconst up    (kbd "C-n"))
(defconst down  (kbd "C-s"))
(defconst left  (kbd "C-h"))
(defconst right (kbd "C-t"))

(defconst pleft  (kbd "C-r"))
(defconst pright (kbd "C-l"))

(defconst lleft  (kbd "C-e"))
(defconst lright (kbd "C-u"))

(defconst lup   (kbd "C-v"))
(defconst ldown (kbd "C-z"))

(global-set-key up    'previous-line)
(global-set-key down  'next-line)
(global-set-key left  'backward-word)
(global-set-key right 'forward-word)

(global-set-key pleft 'backward-char)
(global-set-key pright 'forward-char)
(global-set-key lleft  'move-beginning-of-line)
(global-set-key lright 'move-end-of-line)

(global-set-key lup 'beginning-of-buffer)
(global-set-key ldown 'end-of-buffer)

(global-set-key (kbd "<f12>") '(lambda ()
				 (interactive)
				 (split-window-horizontally)
				 (vterm)))

(global-set-key (kbd "S-<f12>") '(lambda ()
				 (interactive)
				 (split-window-vertically)
				 (vterm)))

(global-set-key (kbd "C-<f12>") #'(lambda ()
				    (interactive)
				    (split-window-horizontally)
				    (cfw:open-org-calendar)))

(global-set-key (kbd "C-f") 'goto-line)

(global-set-key (kbd "C-S-p") '(lambda () (interactive) (scroll-up   10)))
(global-set-key (kbd "C-p")   '(lambda () (interactive) (scroll-down 10)))

(global-set-key (kbd "C-)") 'universal-argument)

(define-prefix-command 'editing-map)
(global-set-key (kbd "C-0") 'editing-map)

(global-set-key (kbd "C-0 s") 'rectangle-mark-mode)
(global-set-key (kbd "C-0 i") 'string-rectangle)
(global-set-key (kbd "C-0 d") 'delete-whitespace-rectangle)

(define-prefix-command 'wm-map)
(global-set-key (kbd "C-9") 'wm-map)

(global-set-key (kbd "C-9 l") 'split-window-horizontally)
(global-set-key (kbd "C-9 r") 'split-window-vertically)
(global-set-key (kbd "C-9 h") 'windmove-left)
(global-set-key (kbd "C-9 t") 'windmove-right)
(global-set-key (kbd "C-9 n") 'windmove-up)
(global-set-key (kbd "C-9 s") 'windmove-down)

(global-set-key (kbd "C-9 d") 'delete-window)

(global-set-key (kbd "C-/") 'swiper)
(global-set-key (kbd "C-x f") 'counsel-find-file)
(global-set-key (kbd "M-x") 'counsel-M-x)

(global-set-key (kbd "RET") #'electric-newline-and-maybe-indent)

;;; Basic UI

(tool-bar-mode -1)
(menu-bar-mode -1)
(global-display-line-numbers-mode 1)
(toggle-scroll-bar -1)
(setq inhibit-startup-message t)

(setq-default header-line-format mode-line-format)
(setq-default mode-line-format '())

(setq-default visual-fill-column-width 80)

;;; Basic Functionality

(setq x-select-enable-clipboard t)

(add-hook 'conf-unix-mode-hook #'flyspell-mode)

(add-hook 'prog-mode-hook '(lambda ()
			     (flyspell-prog-mode)
			     (set 'display-fill-column-indicator-column 80)
			     (display-fill-column-indicator-mode)))

(add-hook 'c-mode-common-hook #'all-the-fancy-things)
(add-hook 'haskell-mode-hook  #'all-the-fancy-things)
(add-hook 'python-mode-hook   #'all-the-fancy-things)
(add-hook 'rustic-mode-hook   #'all-the-fancy-things)

(add-to-list 'auto-mode-alist '("\\.nix\\'" . nix-mode))

(setq-default c-default-style "bsd"
	      c-basic-offset 8
	      indent-tabs-mode t)

;;; Company

(setq company-minimum-prefix-length 1
      company-idle-delay 0.1)

;;; LSP Stuff

;; We allow environment variables to control the language server for
;; more flexibility in the NixOS configuration.
(setq lsp-clangd-binary-path (getenv "LANGSERV_CC"))
(setq lsp-haskell-server-path (getenv "LANGSERV_HK"))

(setq lsp-rust-server 'rust-analyzer)

(setq-default lsp-enable-on-type-formatting nil)

;;; Custom(izations) and Fonts
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background nil))))
 '(org-block ((t (:extend t :background "#FFFFE8" :family "Fira Code"))))
 '(org-inline-source-block ((t (:extend t :background "#FFFFE8" :family "Fira Code"))))
 '(org-checkbox ((t (:background "#FFFFE8" :inherit org-todo :family "Fira Code"))))
 '(org-date ((t (:family "Fira Code"))))
 '(org-document-info-keyword ((t (:inherit shadow :family "Fira Code"))))
 '(org-document-title ((t (:weight bold :height 130 :background "#FFFFE8" :family "Fira Code"))))
 '(org-indent ((t (:inherit org-hide :family "Fira Code"))))
 '(org-level-1 ((t (:family "Fira Code" :overline nil :background "#FFFFE8" :inherit bold :extend nil :height 140))))
 '(org-level-2 ((t (:family "Fira Code" :overline nil :background "#FFFFE8" :inherit bold :extend nil :height 140))))
 '(org-level-3 ((t (:extend nil :overline nil :background "#FFFFE8" :weight semi-bold :family "Fira Code"))))
 '(org-level-4 ((t (:family "Fira Code"))))
 '(org-level-5 ((t (:family "Fira Code"))))
 '(org-meta-line ((t (:family "Fira Code"))))
 '(org-superstar-item ((t (:inherit default :family "Fira Code"))))
 '(org-table ((t (:family "Fira Code"))))
 '(org-todo ((t (:weight bold :family "Fira Code"))))
 '(org-verbatim ((t (:weight semi-bold :family "Fira Code"))))
 '(variable-pitch ((t (:weight normal :height 1.2 :family "Source Serif 4"))))
 '(cfw:face-title ((t (:height 1.4 :inherit variable-pitch))))
 '(cfw:face-day-title ((t (:background "#FFFFFE8"))))
 '(cfw:face-toolbar ((t (:inherit cfw:face-day-title)))))

(set-frame-font "Fira Code 10" nil t)

(custom-set-variables
 '(fira-code-mode-disabled-ligatures '("x"))
 '(org-agenda-files '("/mnt/remote/org/default.org"))
 '(package-selected-packages
   '(acme-theme org-superstar magit flycheck lsp-mode dracula-theme fira-code-mode f ##)))

(setq-default prettify-symbols-compose-predicate
	     (lambda (start end match)
		(and (prettify-symbols-default-compose-p start end match)
		    (is-fira start))))

(fira-code-mode-set-font)
(global-fira-code-mode)
(set-frame-font "Fira Code 10" nil t)

(set-face-font 'default ":antialias=true")

;;; Org mode stuff
(setq calendar-holidays nil)

(setq calendar-day-name-array (make-a-vector
	       (mapcar #'downcase calendar-day-name-array)))

(setq calendar-month-name-array (make-a-vector
	       (mapcar #'downcase calendar-month-name-array)))

(setq org-hide-leading-stars t)
(setq org-superstar-remove-leading-stars t)
(setq org-superstar-leading-bullet ?\s)
(setq org-superstar-headline-bullets-list '(" ")
      org-superstar-item-bullet-alist
      '((?* . ?•)
	(?+ . ?›)
	(?- . ?–)))

(add-hook 'org-mode-hook '(lambda ()
			    (setq line-spacing 4)
			    (setq cursor-type 'bar)
			    (setq org-hide-emphasis-markers t)
			    (visual-line-mode)
			    (org-indent-mode 1)
			    (org-superstar-mode 1)
			    (display-line-numbers-mode -1)
			    (variable-pitch-mode 1)))

;;; mu4e stuff
(setq mu4e-compose-signature
"Lincoln Auster
they/them")

(setq user-full-name "lincoln auster [they/them]"
      user-mail-address "lincolnauster@gmail.com")

(setq send-mail-function 'smtpmail-send-it
      smtpmail-smtp-service 587
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-servers-requiring-authorization ".*"
      smtpmail-stream-type 'starttls
      smtpmail-auth-credentials
        '(("smtp.gmail.com" 587 "lincolnauster@gmail.com"
           (string-trim
	    (shell-command-to-string
	     "gpg -q --batch -q --decrypt ~/.config/gmail-pass.gpg")))))

(add-to-list 'load-path "/run/current-system/sw/share/emacs/site-lisp/mu4e")

;;; Aesthetic Adjustments

(load-theme 'acme 't)
(add-hook 'visual-line-mode-hook '(lambda ()
				    (setq visual-fill-column-center-text t)
				    (visual-fill-column-mode)))

;;; Nuts + bolts

;; aggressive settings copied off of LSP docs
(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 1024))

