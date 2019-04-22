;;; early-init.el --- Early initialization. -*- lexical-binding: t -*-

;; Copyright (C) 2019

;;; Commentary:
;;
;; Early init file for Emacs 27+

;;; Code:

(setq gc-cons-threshold 80000000)
(setq package-enable-at-startup nil)
(setq menu-bar-mode nil)
(setq tool-bar-mode nil)
(setq scroll-bar-mode nil)
(modify-all-frames-parameters '((vertical-scroll-bars)))

(provide 'early-init)
;;; early-init ends here
