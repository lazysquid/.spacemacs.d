;; (when (not (boundp 'org-agenda-files))
;;   (setq org-agenda-files
;;         (append org-agenda-files
;;                 (list (get-journal-file-today))))
;;   )
(with-eval-after-load 'org
  (progn
    ;; Clocking from here. http://doc.norang.ca/org-mode.html#Clocking
    (org-clock-persistence-insinuate)

    (setq org-clock-in-resume t)
    (setq org-clock-out-remove-zero-time-clocks t)
    ;; Save the running clock and all clock history when exiting Emacs, load it on startup
    (setq org-clock-persist t)
    ;; Include current clocking task in clock reports
    (setq org-clock-report-include-clocking-task t)

    (setq org-journal-date-format "%x, %A")
    (setq org-journal-dir (concat org-directory "journals/"))
    (setq org-journal-file-format "%Y%m%d.org")
    (setq org-agenda-files
          (append org-agenda-files
                  (list (fp/get-journal-file-today)
                        (expand-file-name "gtd.org" org-directory))))))

;; (if (boundp 'org-agenda-files)
;;     (append org-agenda-files
;;             (list (get-journal-file-today)))
;;   (setq org-agenda-files (list (get-journal-file-today))))

