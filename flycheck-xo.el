;;; flycheck-xo.el --- Integrate xo with flycheck

;; Copyright (c) 2016 Alex Murray

;; Author: Alex Murray <murray.alex@gmail.com>
;; Maintainer: Alex Murray <murray.alex@gmail.com>
;; URL: https://github.com/alexmurray/flycheck-xo
;; Version: 0.1
;; Package-Requires: ((flycheck "0.24") (emacs "24.4"))

;; This file is not part of GNU Emacs.

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; This packages integrates XO with flycheck to automatically check the style
;; of your JavaScript

;;;; Setup

;; (with-eval-after-load 'flycheck
;;   (require 'flycheck-xo)
;;   (flycheck-xo-setup))

;;; Code:
(require 'flycheck)

(flycheck-def-args-var flycheck-xo-args xo)

(defun flycheck-xo-parse (output checker buffer)
  "Parse ESLint errors/warnings from JSON OUTPUT.
CHECKER and BUFFER denote the CHECKER that returned OUTPUT and
the BUFFER that was checked respectively.
See URL `https://eslint.org' for more information about ESLint."
  (mapcar (lambda (err)
            (let-alist err
              (flycheck-error-new-at
               .line
               .column
               (pcase .severity
                 (2 'error)
                 (1 'warning)
                 (_ 'warning))
               .message
               :id .ruleId
               :checker checker
               :buffer buffer
               :filename (buffer-file-name buffer))))
          (let-alist (caar (flycheck-parse-json output))
            .messages)))

(flycheck-define-checker xo
 "A checker using xo.
See `https://github.com/sindresorhus/xo"
  :command ("xo"
            "--reporter=json"
            "--stdin" "--stdin-filename" source-original
            (eval flycheck-xo-args)
            source)
  :standard-input t
  :error-parser flycheck-xo-parse
  :modes (js-mode js2-mode js2-jsx-mode rjsx-mode js3-mode))
  :working-directory (lambda (_checker)
	  "Look for a working directory to run CHECKER in."
	  (and
	   buffer-file-name
	   (or (locate-dominating-file buffer-file-name "node_modules")
	       (locate-dominating-file buffer-file-name "package.json"))))

;;;###autoload
(defun flycheck-xo-setup ()
  "Setup flycheck-xo.
Add `javascript-xo' to `flycheck-checkers'."
  (interactive)
  ;; prepend to list
  (add-to-list 'flycheck-checkers 'xo))

(provide 'flycheck-xo)

;;; flycheck-xo.el ends here
