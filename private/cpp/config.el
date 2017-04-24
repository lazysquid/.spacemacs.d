;; Create variable called company-backends-c-mode-common
;; This will contain list of company-backends for c-mode-common
(spacemacs|defvar-company-backends c-mode-common)
;; Create variable called company-backends-cmake-mode
;; This will contain list of company-backends for cmake-mode
(spacemacs|defvar-company-backends cmake-mode)

(defvar c-c++-default-mode-for-headers 'c++-mode
  "Default mode to open header files. Can be `c-mode' or `c++-mode'.")
