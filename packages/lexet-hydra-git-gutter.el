;;; lexet-hydra-git-gutter.el --- a simple package                     -*- lexical-binding: t; -*-

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

(defun lexet-hydra-git-gutter-init ()
  "Create lexet git-gutter hydra."
  (defhydra hydra-lexet-hydra-git-gutter (:color teal)
    "git gutter"
    ;; Show current hunk
    ("u"
     (lambda ()
       (interactive)
       (call-interactively 'git-gutter:popup-hunk)
       )
     "Show current hunk")
    ;; Jump to next/previous hunk
    ("n"
     (lambda ()
       (interactive)
       (call-interactively 'git-gutter:next-hunk)
       )
     "Jump to next hunk")
    ("p"
     (lambda ()
       (interactive)
       (call-interactively 'git-gutter:previous-hunk)
       )
     "Jump to previous hunk")
    ;; Stage current hunk
    ("s"
     (lambda ()
       (interactive)
       (call-interactively 'git-gutter:stage-hunk)
       (hydra-lexet-hydra-git-gutter/body)
       )
     "Stage current hunk" :exit t)
    ;; Revert current hunk
    ("r"
     (lambda ()
       (interactive)
       (call-interactively 'git-gutter:revert-hunk)
       (hydra-lexet-hydra-git-gutter/body)
       )
     "Revert current hunk" :exit t)
    ;; Mark current hunk
    ("m"
     (lambda ()
       (interactive)
       (call-interactively 'git-gutter:mark-hunk)
       (hydra-lexet-hydra-git-gutter/body)
       )
     "Mark current hunk" :exit t)

    ("q" nil "exit"))

  (global-set-key (kbd "C-c g") 'hydra-lexet-hydra-git-gutter/body)
  )


(provide 'lexet-hydra-git-gutter)
;;; lexet-hydra-git-gutter.el ends here
