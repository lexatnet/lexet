;;; lexet-hydra-multiple-cursors.el --- a simple package                     -*- lexical-binding: t; -*-

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

;; Create lexet multiple-cursors hydra menu.
;; defines function hydra-lexet-hydra-multiple-cursors
;; which could be binded by global-set-key:

;; (global-set-key (kbd "C-c m") 'hydra-lexet-hydra-multiple-cursors/body)

;; or with use-package:

;; (use-package lexet-hydra-multiple-cursors
;;   :after (multiple-cursors hydra)
;;   :bind (
;;          ("C-c m" . hydra-lexet-hydra-multiple-cursors/body))
;;   )

;;; Code:

(defhydra hydra-lexet-hydra-multiple-cursors ()
  "multiple cursors"

  ("l"
   (lambda ()
     (interactive)
     (call-interactively 'mc/edit-lines)
     )
   "edit lines" :exit t)

  ("a"
   (lambda ()
     (interactive)
     (call-interactively 'mc/mark-all-like-this)
     (hydra-lexet-hydra-multiple-cursors/body)
     )
   "all like this")

  ("n"
   (lambda ()
     (interactive)
     (call-interactively 'mc/mark-next-like-this)
     (hydra-lexet-hydra-multiple-cursors/body)
     )
   "next like this")

  ("N"
   (lambda ()
     (interactive)
     (call-interactively 'mc/skip-to-next-like-this)
     (hydra-lexet-hydra-multiple-cursors/body)
     )
   "skip next")

  ("M-n"
   (lambda ()
     (interactive)
     (call-interactively 'mc/unmark-next-like-this)
     (hydra-lexet-hydra-multiple-cursors/body)
     )
   "unmark next")

  ("p"
   (lambda ()
     (interactive)
     (call-interactively 'mc/mark-previous-like-this)
     (hydra-lexet-hydra-multiple-cursors/body)
     )
   "previous like this")

  ("P"
   (lambda ()
     (interactive)
     (call-interactively 'mc/skip-to-previous-like-this)
     (hydra-lexet-hydra-multiple-cursors/body)
     )
   "skip previous")

  ("M-p"
   (lambda ()
     (interactive)
     (call-interactively 'mc/unmark-previous-like-this)
     (hydra-lexet-hydra-multiple-cursors/body)
     )
   "unmark previous")

  ("d"
   (lambda ()
     (interactive)
     (call-interactively 'mc/mark-all-dwim)
     (hydra-lexet-hydra-multiple-cursors/body)
     )
   "mark dwim")

  ("q"
   nil "exit"))

(provide 'lexet-hydra-multiple-cursors)
;;; lexet-hydra-multiple-cursors.el ends here
