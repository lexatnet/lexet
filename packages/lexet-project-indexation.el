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
  (concat  (file-name-as-directory lexet-tags-root) (file-relative-name file)))


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
      (format "[lexet] lexet process indexation of %s" file)
      "[lexet] tags index"
      "ctags" "-e" "-f"  tag-file-name  (concat default-directory file))
     `(lambda (process event)
       (print (format "[lexet] Process: tag file '%s'" ,tag-file-name))
       (print (format "[lexet] Process: %s had the event '%s'" process event))
       (lexet-add-tags-file ,tag-file-name)))))


(defun lexet-run-project-indexation ()
  (dolist (file-relative-name (projectile-dir-files default-directory default-directory))
    (lexet-run-file-indexation file-relative-name)))


(defun lexet-get-tags-file-name ()
  (concat  (file-name-as-directory lexet-tags-root) "TAGS"))


(defun lexet-index-file-listing (tag-file-name lexet-project-files-listing)
  (set-process-sentinel
     (start-process
      (format "[lexet] tags indexing of %s" lexet-project-files-listing)
      nil
      "ctags" "-e" "-f" tag-file-name "-L" lexet-project-files-listing)
     `(lambda (process event)
        (message "[lexet] Indexation Process: tag file '%s'" ,tag-file-name)
        (message "[lexet] Indexation Process: %s had the event '%s'" process event)
        (lexet-add-tags-file ,tag-file-name))))

(defun lexet-fragmental-indexation (files-listing)
  (dolist (file-name (lexet-read-lines files-listing))
      (lexet-run-file-indexation file-name)))

(defun lexet-relative-project-file-to-absolute-project-file (file-name)
  (concat default-directory file-name))

(defun lexet-list-to-file (file list)
  (append-to-file
   (concat (mapconcat
            #'identity
            list
            "\n") "\n")
   nil
   file))

(defun lexet-fusion-indexation (files-listing)
  (let* (
         (tag-file-name (lexet-get-tags-file-name)))
    (lexet-index-file-listing tag-file-name files-listing)))

(defun lexet-tags-indexation (indexation-strategy)
  (let* (
         (tag-file-name (lexet-get-tags-file-name))
         (tag-file-directory (file-name-directory tag-file-name))
         (lexet-project-files-listing (make-temp-file "lexet-project-files")))
    (message "[lexet] create tags files directory")
    (make-directory tag-file-directory t)
    (message "[lexet] start creation project files listing")
    (message (format "[lexet] project files listing file %s" lexet-project-files-listing))
    (lexet-list-to-file
     lexet-project-files-listing
     (mapcar
      'lexet-relative-project-file-to-absolute-project-file
      (projectile-dir-files default-directory)))
    (message "[lexet] list of files for indexing is ready")
    (cond
     ((string= indexation-strategy "fragmentation")
      (lexet-fragmental-indexation lexet-project-files-listing))
     ((string= indexation-strategy "alinement")
      (lexet-incremental-indexation lexet-project-files-listing))
     ((string= indexation-strategy "fusion")
      (lexet-fusion-indexation lexet-project-files-listing)))))

(defun lexet-incremental-indexation (files-listing)
  (let* (
         (tags-files-list
          (concat
           (file-name-as-directory lexet-tags-root)
           "TAGS-file-list"))
         (incremental-tags-generator
          (concat
           (file-name-as-directory
            (concat
             (file-name-as-directory
              (getenv "through_point"))
             "/lib"))
           "incremental_tags_generation.sh")))
  (set-process-sentinel
     (start-process
      (format "[lexet] tags indexing of %s" files-listing)
      nil
      incremental-tags-generator
      "--file-list" files-listing
      "--tags-root" lexet-tags-root
      "--tags-prefix" "TAGS-"
      "--tags-files-list" tags-files-list
      "--max-tag-file-size" "100000")
     `(lambda (process event)
        (message "[lexet] Indexation Process: tags files list '%s'" ,tags-files-list)
        (message "[lexet] Indexation Process: %s had the event '%s'" process event)
        (dolist (tags-file-name (lexet-read-lines ,tags-files-list))
          (message "[lexet] Add tags file: %s" tags-file-name)
          (lexet-add-tags-file tags-file-name))))))



(defun lexet-project-indexation-init (indexation-strategy)
  "Run project indexation."
  (if (boundp 'lexet-tags-root)
      (progn
        (if (file-exists-p lexet-tags-root)
            (delete-directory lexet-tags-root t))
        (message "[lexet] indexation init")
        (lexet-tags-indexation indexation-strategy)
        (add-hook 'after-save-hook
                  (lambda ()
                    (lexet-run-file-indexation
                     (file-relative-name buffer-file-name (projectile-project-root))))))))


(provide 'lexet-project-indexation)
;;; lexet-project-indexation.el ends here
