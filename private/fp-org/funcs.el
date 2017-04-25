(when (configuration-layer/package-usedp 'org-journal)
  (defun fp/get-journal-file-today ()
    "Return filename for today's journal entry."
    (let ((daily-name (format-time-string "%Y%m%d.org")))
      (expand-file-name (concat org-journal-dir daily-name))))

  (defun fp/journal-file-today ()
    "Create and load a journal file based on today's date."
    (interactive)
    (find-file (get-journal-file-today)))

  (defun fp/get-journal-file-yesterday ()
    "Return filename for yesterday's journal entry."
    (let* ((yesterday (time-subtract (current-time) (days-to-time 1)))
           (daily-name (format-time-string "%Y%m%d.org" yesterday)))
      (expand-file-name (concat org-journal-dir daily-name))))

  (defun fp/journal-file-yesterday ()
    "Creates and load a file based on yesterday's date."
    (interactive)
    (find-file (get-journal-file-yesterday))))

;; options
;; (setq org-directory "~/Dropbox/org/")
;; (unless (file-exists-p org-directory)
;;   (make-directory org-directory))       ;
