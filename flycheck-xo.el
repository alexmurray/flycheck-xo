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

(flycheck-define-checker xo
  "A checker using xo.

See `https://github.com/sindresorhus/xo"
  :command ("xo"
            "--reporter=compact"
            (eval flycheck-xo-args)
            source)
  :error-patterns ((error line-start
                          (file-name) ": line " line ", col " column ", Error - "
                          (message (one-or-more not-newline)
                                   (zero-or-more "\n"
                                                 (one-or-more " ")
                                                 (one-or-more not-newline))) line-end)
                   (warning line-start
                            (file-name) ": line " line ", col " column ", Warning - "
                            (message (one-or-more not-newline)
                                     (zero-or-more "\n"
                                                   (one-or-more " ")
                                                   (one-or-more not-newline))) line-end))
  :modes (js-mode js2-mode js3-mode))

;;;###autoload
(defun flycheck-xo-setup ()
  "Setup flycheck-xo.

Add `xo' to `flycheck-checkers'."
  (interactive)
  ;; prepend to list
  (add-to-list 'flycheck-checkers 'xo))

(provide 'flycheck-xo)

;;; flycheck-xo.el ends here
