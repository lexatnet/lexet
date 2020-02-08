;;; lexet-indentation.el --- a simple package                     -*- lexical-binding: t; -*-

;; Copyright (C) 2014  Nic Ferrier

;; Author: Aleksey Romanov <lex.at.net@gmail.com>
;; Keywords: lisp
;; Version: 0.0.1

;; This program is free software; you can redistribute it and/or modify
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

;; Put a description of the package here

;;; Code:

(defun lexet-indentation-init ()
    "Indent configuration."
    (setq lexet-indent 2)
    (setq c-basic-offset lexet-indent)
    (setq-default indent-tabs-mode nil)
    (setq default-tab-width lexet-indent)
    (setq tab-width lexet-indent)
    (setq js-indent-level lexet-indent)
    (setq web-mode-markup-indent-offset lexet-indent)
    (setq web-mode-css-indent-offset lexet-indent)
    (setq web-mode-code-indent-offset lexet-indent)
    (setq sh-basic-offset lexet-indent)
    (setq sh-indentation lexet-indent)
    (setq python-indent-offset lexet-indent)
    (setq sql-indent-offset lexet-indent)
    (setq css-indent-offset lexet-indent)
    (setq sgml-basic-offset lexet-indent)
    )


(provide 'lexet-indentation)
;;; lexet-indentation.el ends here

