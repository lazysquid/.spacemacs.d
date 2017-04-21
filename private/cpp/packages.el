;;; packages.el --- cpp layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author: fpenguin23 <fpenguin23@Ubuntu-Lab>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `cpp-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `cpp/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `cpp/pre-init-PACKAGE' and/or
;;   `cpp/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst cpp-packages
  '(
    cc-mode
    disaster
    company
    company-irony
    flycheck
    flycheck-irony
    rtags
    cmake-ide
    irony
    cmake-mode
    gdb-mi
    )
  "The list of Lisp packages required by the cpp layer.

Each entry is either:

1. A symbol, which is interpreted as a package to be installed, or

2. A list of the form (PACKAGE KEYS...), where PACKAGE is the
    name of the package to be installed or loaded, and KEYS are
    any number of keyword-value-pairs.

    The following keys are accepted:

    - :excluded (t or nil): Prevent the package from being loaded
      if value is non-nil

    - :location: Specify a custom installation location.
      The following values are legal:

      - The symbol `elpa' (default) means PACKAGE will be
        installed using the Emacs package manager.

      - The symbol `local' directs Spacemacs to load the file at
        `./local/PACKAGE/PACKAGE.el'

      - A list beginning with the symbol `recipe' is a melpa
        recipe.  See: https://github.com/milkypostman/melpa#recipe-format")


;;"This is stolen from spacemacs c-c++ layer"
(defun cpp/init-cc-mode ()
  (use-package cc-mode
    :defer t
    :init
    (progn
      (add-to-list 'auto-mode-alist
                   `("\\.h\\'" . ,c-c++-default-mode-for-headers)))
    :config
    (progn
      (require 'compile)
      (c-toggle-auto-newline 1)
      (spacemacs/set-leader-keys-for-major-mode 'c-mode
        "ga" 'projectile-find-other-file
        "gA" 'projectile-find-other-file-other-window)
      (spacemacs/set-leader-keys-for-major-mode 'c++-mode
        "ga" 'projectile-find-other-file
        "gA" 'projectile-find-other-file-other-window))))


;;"This is stolen from spacemacs c-c++ layer"
(defun cpp/init-disaster ()
  (use-package disaster
    :defer t
    :commands (disaster)
    :init
    (progn
      (spacemacs/set-leader-keys-for-major-mode 'c-mode
        "D" 'disaster)
      (spacemacs/set-leader-keys-for-major-mode 'c++-mode
        "D" 'disaster))))

;;"This is stolen from spacemacs c-c++ layer"
(defun cpp/init-cmake-mode ()
  (use-package cmake-mode
    :mode (("CMakeLists\\.txt\\'" . cmake-mode) ("\\.cmake\\'" . cmake-mode))
    :init (push 'company-cmake company-backends-cmake-mode)))


;;"This is stolen from spacemacs c-c++ layer"
(defun cpp/post-init-company ()
  (spacemacs|add-company-hook c-mode-common)
  (spacemacs|add-company-hook cmake-mode))

;;"This is stolen from spacemacs c-c++ layer"
(defun cpp/init-gdb-mi ()
  (use-package gdb-mi
    :defer t
    :init
    (setq
     ;; use gdb-many-windows by default when `M-x gdb'
     gdb-many-windows t
     ;; Non-nil means display source file containing the main routine at startup
     gdb-show-main t)))

;;"This is stolen from spacemacs c-c++ layer"
(defun cpp/post-init-flycheck ()
  (dolist (mode '(c-mode c++-mode))
    (spacemacs/add-flycheck-hook mode))
  )

(defun cpp/init-cmake-ide ()
  (use-package cmake-ide
    :defer t
    :after (irony rtags)
    :config
    (cmake-ide-setup)))

(defun cpp/init-rtags ()
  (use-package rtags
    :defer t))

(defun cpp/init-irony ()
  (use-package irony
    :init
    :defer t
    (progn
      (add-hook 'c++-mode-hook 'irony-mode)
      (add-hook 'c-mode-hook 'irony-mode)
      (add-hook 'objc-mode-hook 'irony-mode)
      (add-hook 'irony-mode-hook
                (lambda ()
                  (define-key irony-mode-map [remap completion-at-point]
                    'irony-completion-at-point-async)
                  (define-key irony-mode-map [remap complete-symbol]
                    'irony-completion-at-point-async)))
      (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
      (spacemacs|diminish irony-mode " Ⓘ" " I"))))

(defun cpp/init-company-irony ()
  (use-package company-irony
    :init
    :defer t
    (progn
      (eval-after-load 'company
        '(add-to-list 'company-backends 'company-irony))
      (add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)
      (add-hook 'irony-mode-hook 'company-mode))))

(defun cpp/init-flycheck-irony ()
  (use-package flycheck-irony
    :init
    :defer t
    (progn
      (eval-after-load 'flycheck
        '(add-to-list 'flycheck-checkers 'irony))
      (add-hook 'irony-mode-hook 'flycheck-mode))))


;;; packages.el ends here
