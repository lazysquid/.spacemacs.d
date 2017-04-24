;; (when (not (boundp 'org-agenda-files))
;;   (setq org-agenda-files
;;         (append org-agenda-files
;;                 (list (get-journal-file-today))))
;;   )
(with-eval-after-load 'org
  (progn
    (setq org-journal-date-format "%x, %A")
    (setq org-journal-dir (concat org-directory "journals/"))
    (setq org-journal-file-format "%Y%m%d.org")
    (setq org-agenda-files
          (append org-agenda-files
                  (list (fp/get-journal-file-today))))))

;; (if (boundp 'org-agenda-files)
;;     (append org-agenda-files
;;             (list (get-journal-file-today)))
;;   (setq org-agenda-files (list (get-journal-file-today))))

