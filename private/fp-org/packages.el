;;; packages.el --- fp-org layer packages file for Spacemacs.
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
;; added to `fp-org-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `fp-org/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `fp-org/pre-init-PACKAGE' and/or
;;   `fp-org/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst fp-org-packages
  '(
    org-journal
    org-page
    org-ref
    ;;org-babel
    interleave
    )
  "The list of Lisp packages required by the fp-org layer.

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


(defun fp-org/init-org-ref()
  (use-package org-ref
    :config
    (setq
     org-ref-bibliography-notes (concat org-directory "research-note/research.org")
     org-ref-default-bibliography (concat org-directory "research-note/ref.bib")
     org-ref-pdf-directory (concat org-directory "research-note/pdf"))))

(defun fp-org/init-interleave ()
  (use-package interleave)
  )

(defun fp-org/init-org-journal ()
  (use-package org-journal
    )
  )

;; (defun fp-org/init-org-babel()
;;   (use-package org-babel
;;     :config
;;     (org-babel-do-load-languages
;;      'org-babel-load-languages
;;      '((sh         . t)
;;        (emacs-lisp . t)
;;        (python     . t)
;;        (dot        . t)
;;        (C          . t)
;;        (plantuml   . t)))))

(defun fp-org/init-org-page ()
  (use-package org-page
    :config
    (setq op/repository-directory (concat fp/dropbox-directory "blog/"))
    (setq op/site-domain "frostedpenguin.github.com")
    (setq op/personal-github-link "http://github.com/frostedpenguin")
    (setq op/personal-google-analytics-id "UA-86199041-1")
    (setq op/personal-avatar "https://avatars2.githubusercontent.com/u/6973543?v=3&s=466")
    (setq op/site-main-title "Span {thought}")
    (setq op/site-sub-title "Set of my orthogonal thoughts")
    (setq op/category-ignore-list
          '("images"))
    (setq op/category-config-alist
          '(("wiki"
             :show-meta t
             :show-comment nil
             :uri-generator op/generate-uri
             :uri-template "/wiki/%t/"
             :sort-by :mod-date
             :category-index t)

            ("blog" ;; this is the default configuration
             :show-meta t
             :show-comment nil
             :uri-generator op/generate-uri
             :uri-template "/blog/%y/%m/%d/%t/"
             :sort-by :date     ;; how to sort the posts
             :category-index t) ;; generate category index or not

            ("index"
             :show-meta nil
             :show-comment nil
             :uri-generator op/generate-uri
             :uri-template "/"
             :sort-by :date
             :category-index nil)

            ("about"
             :show-meta nil
             :show-comment nil
             :uri-generator op/generate-uri
             :uri-template "/about/"
             :sort-by :date
             :category-index nil)
            ))))


;;; packages.el ends here
