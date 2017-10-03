;; (when (not (boundp 'org-agenda-files))
;;   (setq org-agenda-files
;;         (append org-agenda-files
;;                 (list (get-journal-file-today))))
;;   )
(with-eval-after-load 'org
  (progn
    ;; add org-habit
    (add-to-list 'org-modules 'org-habit)

    ;; Clocking from here. http://doc.norang.ca/org-mode.html#Clocking
    (org-clock-persistence-insinuate)

    ;; my custom org-todo-keywords setup
    (setq org-todo-keywords
          '((sequence "TODO(t)" "|" "DONE(d)")
            (sequence "PLAN(p)" "|" "FAILED(f)" "DONE(d)") ;; for my daily routin plan
            (sequence "|" "CANCLED(c)" )))

    ;; set colors for this sequneces
    (setq org-todo-keyword-faces
          '(("TODO" . org-todo) ("DONE" . org-done)
            ("PLAN" . "yellow") ("FAILED" . "royal blue") ("DONE" . org-done)
            ("CANCLED" . "tomato")))



    (setq org-clock-in-resume t)
    (setq org-clock-out-remove-zero-time-clocks t)
    ;; Save the running clock and all clock history when exiting Emacs, load it on startup
    (setq org-clock-persist t)
    ;; Include current clocking task in clock reports
    (setq org-clock-report-include-clocking-task t)

    (setq org-journal-date-format "%x, %A")
    (setq org-journal-dir (concat org-directory "/journals/"))
    (setq org-journal-file-format "%Y%m%d.org")
    (setq org-agenda-files
          (append org-agenda-files
                  (list org-journal-dir
                        ;;(file-expand-wildcards (concat org-journal-dir "*.org"))
                        ;;(fp/get-journal-file-today)
                        (expand-file-name "habit.org" org-directory)
                        (expand-file-name "todo.org" org-directory)
                        (expand-file-name "research.org" org-directory)
                        ;;(expand-file-name "gtd.org" org-directory)
                        ))))
  )


;; (if (boundp 'org-agenda-files)
;;     (append org-agenda-files
;;             (list (get-journal-file-today)))
;;   (setq org-agenda-files (list (get-journal-file-today))))

