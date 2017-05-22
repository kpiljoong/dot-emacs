;;; init.el --- Where all the magic begins
;;
;;



;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(setq gc-cons-threshold 100000000)
(defconst hkk/version "0.1" "hkk version")
(defconst hkk/min-version "24.3" "Minimal required version of emacs")

(setq message-log-max 16384)
(defconst emacs-start-time (current-time))

(require 'org)
(require 'ob)
(require 'ob-tangle)
(require 'em-glob)

(defconst hkk-emacs-directory (concat (getenv "HOME") "/.emacs.d/"))
(defconst hkk-emacs-cache-directory (expand-file-name (concat hkk-emacs-directory ".cache/")))


(defun hkk/get-path (file)
  (concat "~/.emacs.d/hkk/" file))

(defun hkk/get-files (path)
  (file-expand-wildcards path))

(defun hkk/mkdir (path)
  (unless (file-exists-p path)
    (make-directory path t)))

(defun hkk/load-core ()
  (interactive)
  (require 'hkk-core (hkk/get-path "hkk-core.el")))

(defun hkk/tangle-file (file)
  (interactive "fOrg File: ")
  (message (concat "file: " file))
  (find-file file)
  (org-babel-tangle)
  (kill-buffer))

(defun hkk/tangle-files (path)
  (interactive "D")
  (let ((files (hkk/get-files path)))
    (mapc 'hkk/tangle-file files)))

(defun hkk/babel-org-files ()
  (interactive)
  ; create hkk directory
  (hkk/mkdir "~/.emacs.d/hkk")
  (hkk/mkdir hkk-emacs-cache-directory)
  ; tangling org files
  (hkk/tangle-files "~/.emacs.d/*.org")
  (message "hkk :: finished babeling org fiels")
  ; load core script
  (hkk/load-core))

;; add the hkk path into the load paths
(add-to-list 'load-path (hkk/get-path nil))

;; babeling org files
(hkk/babel-org-files)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (color-theme-sanityinc-tomorrow use-package which-key bind-key bind-map evil undo-tree goto-chg))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-tooltip-common ((t (:inherit company-tooltip :weight bold :underline nil))))
 '(company-tooltip-common-selection ((t (:inherit company-tooltip-selection :weight bold :underilne nil)))))
