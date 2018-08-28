;;; lexet-project-indexation.el --- a simple package                     -*- lexical-binding: t; -*-

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

(require 'projectile)

(setq lexet-tags-root (getenv "lexet_tags_dir"))

(defun lexet-read-lines (filePath)
  "Return a list of lines of a file at FILEPATH."
  (with-temp-buffer
    (insert-file-contents filePath)
    (split-string (buffer-string) "\n" t)))


(defun lexet-exclude (fn)
  (if (remove nil (mapcar (lambda (m) (string-match m fn)) (read-lines (getenv "ctags_exclude_config_path")))) nil fn))


(defun lexet-create-project-files-list ()
  "Return list of files in lexet project directory"
  (mapcar 'lexet-exclude (directory-files-recursively default-directory "")))


(defun lexet-generate-tags-filename (file)
  (format "%s/%s" lexet-tags-root file))


(defun lexet-add-tags-file (file)
    (progn
      (add-to-list 'tags-table-list file)
      (tags-completion-table)))


(defun lexet-run-file-indexation (file)
  (let* ((tag-file-name (lexet-generate-tags-filename file))
         (tag-file-directory (file-name-directory tag-file-name)))
    (make-directory tag-file-directory t)
    (set-process-sentinel
     (start-process
      (format "lexet process indexation of %s" file)
      "lexet tags index"
      "etags" "-f"  tag-file-name  (concat default-directory file))
     `(lambda (process event)
       (print (format "Process: tag file '%s'" ,tag-file-name))
       (print (format "Process: %s had the event '%s'" process event))
       (lexet-add-tags-file ,tag-file-name)))))


(defun lexet-run-project-indexation ()
  (dolist (file-relative-name (projectile-dir-files default-directory))
    (lexet-run-file-indexation file-relative-name)))


(defun lexet-get-tags-file-name ()
  (format "%s/%s" lexet-tags-root "TAGS"))


(defun lexet-tags-indexation ()
  (let* (
         (tag-file-name (lexet-get-tags-file-name))
         (tag-file-directory (file-name-directory tag-file-name))
         (lexet-project-files-listing (make-temp-file "lexet-project-files")))
    (make-directory tag-file-directory t)
    (append-to-file
     (concat (mapconcat
      (lambda (file-relative-name) (concat default-directory file-relative-name))
      (projectile-dir-files default-directory)
      "\n") "\n")
     nil
     lexet-project-files-listing)
    (message "[lexet] list of files for indexing is ready")
    (set-process-sentinel
     (start-process
      (format "[lexet] tags indexing of %s" lexet-project-files-listing)
      nil
      "ctags" "-e" "-f"  tag-file-name  "-L" lexet-project-files-listing)
     `(lambda (process event)
        (message "[lexet] Indexation Process: tag file '%s'" ,tag-file-name)
        (message "[lexet] Indexation Process: %s had the event '%s'" process event)
        (lexet-add-tags-file ,tag-file-name)))
    )
  )



(defun lexet-project-indexation-init ()
  "Run project indexation."
  (if (boundp 'lexet-tags-root)
      (progn
        (if (file-exists-p lexet-tags-root)
            (delete-directory lexet-tags-root t))
        (lexet-tags-indexation)
        (add-hook 'after-save-hook
                  (lambda ()
                    (lexet-run-file-indexation
                     (file-relative-name buffer-file-name (projectile-project-root))))))))


(provide 'lexet-project-indexation)
;;; lexet-project-indexation.el ends here
