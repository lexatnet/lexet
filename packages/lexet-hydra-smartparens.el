;;; lexet-hydra-smartparens.el --- a simple package                     -*- lexical-binding: t; -*-

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

;; Create lexet smartparens hydra menu.
;; defines function hydra-lexet-hydra-smartparens
;; which could be binded by global-set-key:

;; (global-set-key (kbd "C-c s") 'hydra-lexet-hydra-smartparens/body)

;; or with use-package:

;; (use-package lexet-hydra-smartparens
;;   :after (smartparens hydra)
;;   :bind (
;;          ("C-c s" . hydra-lexet-hydra-smartparens/body))
;;   )

;;; Code:

(defhydra hydra-lexet-hydra-smartparens ()
  "Smartparens"

  ("d"
   (lambda ()
     (interactive)
     (call-interactively 'sp-down-sexp)
     (hydra-lexet-hydra-smartparens/body)
     )
   "Down")

  ("u"
   (lambda ()
     (interactive)
     (call-interactively 'sp-up-sexp)
     (hydra-lexet-hydra-smartparens/body)
     )
   "Up")

  ("U"
   (lambda ()
     (interactive)
     (call-interactively 'sp-backward-up-sexp)
     (hydra-lexet-hydra-smartparens/body)
     )
   "Up")

  ("D"
   (lambda ()
     (interactive)
     (call-interactively 'sp-backward-down-sexp)
     (hydra-lexet-hydra-smartparens/body)
     )
   "Down")

  ("f"
   (lambda ()
     (interactive)
     (call-interactively 'sp-forward-sexp)
     (hydra-lexet-hydra-smartparens/body)
     )
   "Forward")

  ("b"
   (lambda ()
     (interactive)
     (call-interactively 'sp-backward-sexp)
     (hydra-lexet-hydra-smartparens/body)
     )
   "Backward"
   )

  ("r"
   (lambda ()
     (interactive)
     (call-interactively 'sp-rewrap-sexp)
     (hydra-lexet-hydra-smartparens/body)
     )
   "Re-wrap"
   )

  ("s"
   (lambda ()
     (interactive)
     (call-interactively 'sp-splice-sexp)
     (hydra-lexet-hydra-smartparens/body)
     )
   "Un-wrap"
   )

  ("o"
   (lambda ()
     (interactive)
     (call-interactively 'sp-change-inner)
     (hydra-lexet-hydra-smartparens/body)
     )
   "Override"
   )

  ("k"
   (lambda ()
     (interactive)
     (call-interactively 'sp-kill-sexp)
     (hydra-lexet-hydra-smartparens/body)
     )
   "Kill"
   :color blue
   )

  ("q"
   nil "Quit" :color blue))


(provide 'lexet-hydra-smartparens)
;;; lexet-hydra-smartparens.el ends here
