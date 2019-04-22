;;; init.el --- Emacs configuration	-*- lexical-binding: t no-byte-compile: t; -*-

;;; Copyright 2019 Dovydas Stepanavicius

;;; Commentary:
;;
;; Emacs configuration

;;; Code:

;; Speed up startup
(defvar default-file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)
(setq gc-cons-threshold 80000000)
(add-hook 'emacs-startup-hook
          (lambda ()
            "Restore defalut values after init."
            (setq file-name-handler-alist default-file-name-handler-alist)
            (setq gc-cons-threshold 800000)
            (if (boundp 'after-focus-change-function)
                (add-function :after after-focus-change-function
                              (lambda ()
                                (unless (frame-focus-state)
                                  (garbage-collect))))
              (add-hook 'focus-out-hook 'garbage-collect))))

(unless (>= emacs-major-version 27)
  (tool-bar-mode -1)
  (menu-bar-mode -1)
  (scroll-bar-mode -1))

;; Suppress GUI features
(setq use-file-dialog nil)
(setq use-dialog-box nil)
(setq inhibit-startup-screen t)
(setq inhibit-startup-echo-area-message t)
(size-indication-mode 1)
;; (blink-cursor-mode -1)
(setq track-eol t)                      ; Keep cursor at end of lines. Require line-move-visual is nil.
(setq line-move-visual nil)
(setq inhibit-compacting-font-caches t) ; Don’t compact font caches during GC.

(setq package-archives '(("ELPA"  . "http://tromey.com/elpa/")
             ("gnu"   . "http://elpa.gnu.org/packages/")
             ("melpa" . "http://melpa.org/packages/")
             ("org"   . "http://orgmode.org/elpa/")))

(unless (bound-and-true-p package--initialized)
  (require 'package)
  (setq package-enable-at-startup nil)
  (package-initialize))

;;; Bootstrapping use-package
(unless (package-installed-p 'use-package)
 (package-refresh-contents)
 (package-install 'use-package))

;; Should set before loading `use-package'
(eval-and-compile
  (setq use-package-always-ensure t)
;;  (setq use-package-always-defer t)
  (setq use-package-expand-minimally t)
  (setq use-package-enable-imenu-support t))

(eval-when-compile
  (require 'use-package))

;; Enable async package
(use-package async
  :init (dired-async-mode 1)
  (async-bytecomp-package-mode 1))

;;; Enable Org-bable and source the Org style config file
 (when (file-readable-p "~/.emacs.d/config.org")
   (org-babel-load-file (expand-file-name "~/.emacs.d/config.org")))

(provide 'init)
;;; init.el ends here
