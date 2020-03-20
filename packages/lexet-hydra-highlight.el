;;; lexet-hydra-highlight.el --- a simple package                     -*- lexical-binding: t; -*-

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

;; Create lexet highlight hydra menu.
;; defines function hydra-lexet-hydra-highlight
;; which could be binded by global-set-key:

;; (global-set-key (kbd "C-c h") 'hydra-lexet-hydra-higlight/body)

;; or with use-paackage:

;; (use-package hydra-lexet-hydra-higlight
;;   :after (treemacs hydra)
;;   :bind (
;;          ("C-c h" . hydra-lexet-hydra-higlight/body))
;;   )


;;; Code:

(defhydra hydra-lexet-hydra-higlight ()
  "highlight"
  ("a"
   (lambda ()
     (interactive)
     (call-interactively 'hlt-unhighlight-all-prop)
     )
   "unhighlight all" :exit t)
  ("s"
   (lambda ()
     (interactive)
     (call-interactively 'highlight-region-in-buffer)
     )
   "highlight region in buffer" :exit t)
  ("n"
   (lambda ()
     (interactive)
     (call-interactively 'hlt-next-highlight)
     (hydra-lexet-hydra-higlight/body)
     )
   "highlight next" :exit t)

  ("p"
   (lambda ()
     (interactive)
     (call-interactively 'hlt-previous-highlight)
     (hydra-lexet-hydra-higlight/body)
     )
   "highlight previous" :exit t)

  ("q" nil "exit"))


(provide 'lexet-hydra-highlight)
;;; lexet-hydra-highlight.el ends here
