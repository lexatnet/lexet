;;; lexet-use-eslint-from-node-modules.el --- a simple package                     -*- lexical-binding: t; -*-

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

(defun lexet/use-eslint-from-node-modules ()
  "use local eslint from node_modules before global"
  (let* (
         (node-path (getenv "NODE_PATH"))
         (node-paths (split-string (if node-path node-path "") ":"))
         (root (locate-dominating-file
                (or (buffer-file-name) default-directory)
                "node_modules"))
         (eslint (and root
                      (expand-file-name "node_modules/.bin/eslint" root))))
    (when (and eslint (file-executable-p eslint))
      (when (not (member root node-paths))
        (message "root->%s" root)
        (message "node-paths->%s" node-paths)
        (add-to-list 'node-paths root)
        (message "node-paths->%s" node-paths)
        (let (
              (new-node-path (mapconcat 'identity node-paths ":")))
          (message "new-node-path->%s" new-node-path)
          (setenv "NODE_PATH" new-node-path)
          (message "NODE_PATH->%s" (getenv "NODE_PATH"))
          ))
      (message "eslint->%s" eslint)
      (setq-local flycheck-javascript-eslint-executable eslint))))


(provide 'lexet-use-eslint-from-node-modules)
;;; lexet-use-eslint-from-node-modules.el ends here

