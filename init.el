'''
;;; Setup some memory performance here
(setq gc-cons-threshold 402653184
     gc-cons-percentage 0.6)

(defvar startup/file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)


;;; This is all kinds of necessary
(require 'package)
(setq package-enable-at-startup nil)

;;; Set basic package URL
(setq package-archives '(("ELPA"  . "http://tromey.com/elpa/")
             ("gnu"   . "http://elpa.gnu.org/packages/")
             ("melpa" . "http://melpa.org/packages/")
             ("org"   . "http://orgmode.org/elpa/")))
(package-initialize)

;;; Bootstrapping use-package
(unless (package-installed-p 'use-package)
 (package-refresh-contents)
 (package-install 'use-package))


;;; Enable Org-bable and source the Org style config file
 (when (file-readable-p "~/.emacs.d/config.org")
   (org-babel-load-file (expand-file-name "~/.emacs.d/config.org")))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (markdown-mode groovy-mode yaml-mode avy counsel swiper ivy company-quickhelp neotree zerodark-theme slime-company slime org-jira flycheck elpy ob-shell yasnippet-snippets yasnippet org-bullets fancy-battery spaceline spacemacs-theme which-key use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq gc-cons-threshold (* 2 1000 1000))
(defun startup/reset-gc ()
 (setq gc-cons-threshold 16777216
       gc-cons-percentage 0.1))
