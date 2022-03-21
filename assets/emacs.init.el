(tool-bar-mode -1)
(menu-bar-mode -1)
(global-display-line-numbers-mode 1)
(toggle-scroll-bar -1)

;; i just copied this off of LSP docs - they seem aggressive, but they certainly
;; work.
(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 1024))

(setq inhibit-startup-message t)

(setq-default left-margin-width  2)
(setq-default right-margin-width 2)

(setq-default header-line-format mode-line-format)
(setq-default mode-line-format '())

(add-hook 'conf-unix-mode-hook '(lambda ()
			(local-set-key (kbd "RET")
				       'electric-newline-and-maybe-indent)))

(add-hook 'text-mode-hook '(lambda ()
			(local-set-key (kbd "RET")
				       'electric-newline-and-maybe-indent)))

(add-hook 'prog-mode-hook '(lambda ()
			      (local-set-key (kbd "RET")
					     'electric-newline-and-maybe-indent)
			      (set 'display-fill-column-indicator-column 80)
			      (display-fill-column-indicator-mode)))

(require 'package)
(add-to-list 'package-archives '("nongnu" . "https://elpa.nongnu.org/nongnu/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

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

(global-set-key (kbd "C-f") 'goto-line)

(global-set-key (kbd "C-m") 'scroll-down)
(global-set-key (kbd "C-b") 'scroll-up)

(global-set-key (kbd "C-)") 'universal-argument)

(define-prefix-command 'editing-map)
(global-set-key (kbd "C-0") 'editing-map)

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
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(fira-code-mode-disabled-ligatures '("x"))
 '(org-agenda-files '("/mnt/remote/org/default.org"))
 '(package-selected-packages
   '(org-superstar magit doom-themes ccls flycheck lsp-mode dracula-theme fira-code-mode f ##)))

(require 'fira-code-mode)
(fira-code-mode-set-font)
(global-fira-code-mode)
(set-frame-font "Fira Code 11" nil t)

(set-face-font 'default ":antialias=true")
(load-theme 'doom-nord-light 't)

(setq company-minimum-prefix-length 1
      company-idle-delay 0.1)

(setq-default c-default-style "bsd"
	      c-basic-offset 8
	      indent-tabs-mode t)

(add-to-list 'auto-mode-alist '("\\.nix\\'" . prog-mode))

(require 'lsp-mode)

(add-hook 'c-mode-hook '(lambda ()
			  (flycheck-mode)
			  (require 'ccls)
			  (lsp)
			  (company-mode)))

(add-hook 'python-mode-hook '(lambda ()
			       (flycheck-mode)
			       (lsp)
			       (company-mode)))

(require 'org-superstar)
(setq org-hide-leading-stars t)
(setq org-superstar-remove-leading-stars t)
(setq org-superstar-leading-bullet ?\s)
(setq org-superstar-headline-bullets-list '(" "))

(add-hook 'org-mode-hook '(lambda ()
			    (setq line-spacing 4)
			    (setq cursor-type 'bar)
			    (setq org-hide-emphasis-markers t)
			    (visual-line-mode)
			    (org-indent-mode 1)
			    (org-superstar-mode 1)
			    (display-line-numbers-mode -1)
			    (variable-pitch-mode 1)))

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
	     "gpg -q --batch -q --decrypt ~/.config/mutt/account.gpg")))))

(add-to-list 'load-path "/run/current-system/sw/share/emacs/site-lisp/mu4e")
(require 'mu4e)


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background nil))))
 '(org-block ((t (:extend t :background "#C2D0E7" :family "FiraCode"))))
 '(org-checkbox ((t (:inherit org-todo :family "FiraCode"))))
 '(org-date ((t (:foreground "#9A7500" :family "FiraCode"))))
 '(org-document-info-keyword ((t (:inherit shadow :family "FiraCode"))))
 '(org-document-title ((t (:foreground "#ffb86c" :weight bold :height 130 :family "FiraCode"))))
 '(org-indent ((t (:inherit org-hide :family "FiraCode"))))
 '(org-level-1 ((t (:family "FiraCode" :inherit bold :extend nil :foreground "#ff79c6" :height 140))))
 '(org-level-2 ((t (:family "FiraCode" :inherit bold :extend nil :foreground "#bd93f9" :height 140))))
 '(org-level-3 ((t (:extend nil :weight semi-bold :family "FiraCode"))))
 '(org-level-4 ((t (:family "FiraCode"))))
 '(org-level-5 ((t (:family "FiraCode"))))
 '(org-meta-line ((t (:foreground "#828b9b" :family "FiraCode"))))
 '(org-superstar-item ((t (:inherit default :family "FiraCode"))))
 '(org-table ((t (:foreground "#842879" :family "FiraCode"))))
 '(org-todo ((t (:foreground "#4a4a4a" :weight bold :family "FiraCode"))))
 '(org-verbatim ((t (:foreground "#4F894C" :weight semi-bold :family "FiraCode"))))
 '(variable-pitch ((t (:weight normal :height 1.2 :family "SourceSerif4")))))
