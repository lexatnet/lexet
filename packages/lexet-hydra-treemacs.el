;;; lexet-hydra-treemacs.el --- a simple package                     -*- lexical-binding: t; -*-

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

;; Create lexet treemacs hydra menu.
;; defines function hydra-lexet-hydra-treemacs
;; which could be binded by global-set-key:

;; (global-set-key (kbd "C-c t") 'hydra-lexet-hydra-treemacs/body)

;; or with use-package:

;; (use-package lexet-hydra-treemacs
;;   :after (treemacs hydra)
;;   :bind (
;;          ("C-c t" . hydra-lexet-hydra-treemacs/body))
;;   )

;;; Code:

(defhydra hydra-lexet-hydra-treemacs-file ()
  "treemacs file"
  ("f"
   (lambda ()
     (interactive)
     (call-interactively 'treemacs-find-file)
     )
   "find file" :exit t)
  ("t"
   (lambda ()
     (interactive)
     (call-interactively 'treemacs-find-tag)
     )
   "find tag" :exit t)

  ("q"
   nil
   "exit"))

(defhydra hydra-lexet-hydra-treemacs ()
  "treemacs"

  ("t"
   (lambda ()
     (interactive)
     (call-interactively 'treemacs)
     )
   "toggle treemacs" :exit t)

  ("b"
   (lambda ()
     (interactive)
     (call-interactively 'treemacs-select-window)
     )
   "focus tree(browse)" :exit t)

  ("1"
   (lambda ()
     (interactive)
     (call-interactively 'treemacs-delete-other-windows)
     )
   "delete other windows" :exit t)

  ("B"
   (lambda ()
     (interactive)
     (call-interactively 'treemacs-bookmark)
     )
   "bookmark" :exit t)

  ("f"
   (lambda ()
     (interactive)
     (hydra-lexet-hydra-treemacs-file/body)
     )
   "file menu" :exit t)

  ("q"
   nil "exit"))


(provide 'lexet-hydra-treemacs)
;;; lexet-hydra-treemacs.el ends here
