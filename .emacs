;;; package --- Summary
;;; Commentary:
;;; Code:
(setq package-user-dir (getenv "ide_packages_dir"))

(menu-bar-mode -1)
(tool-bar-mode -1)
(setq inhibit-startup-screen t)

(setq-default frame-title-format '("ide@%f"))

(load-theme 'tango-dark)

; list the packages you want
(setq package-list
      '(
        highlight
        zones
        highlight-symbol
        auto-complete
        php-mode
        web-mode
        ac-php
        json-mode
        js2-mode
        ac-js2
        projectile
        neotree
        magit
        git-gutter
        scss-mode
        flycheck
        ac-etags
        el-get
        undo-tree
        multiple-cursors
        highlight-indent-guides
        yaml-mode
        expand-region
        markdown-mode))

(require 'package)

;(add-to-list 'package-archives
;             '("melpa-stable" . "http://stable.melpa.org/packages/") t)

(setq package-archives
        '(("melpa" . "https://melpa.org/packages/")) )

(package-initialize)

; fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))


; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))



(require 'el-get)



(require 'highlight-symbol)
(add-hook 'prog-mode-hook 'highlight-symbol-mode)
(add-hook 'text-mode-hook 'highlight-symbol-mode)
(global-set-key (kbd "M-<right>") 'highlight-symbol-next)
(global-set-key (kbd "M-<left>") 'highlight-symbol-prev)




(require 'zones)



(require 'highlight)
(global-set-key (kbd "C-x C-a") 'hlt-unhighlight-all-prop)
(global-set-key (kbd "C-x C-h") 'highlight-region-in-buffer)

(defun get-selected-string (beg end)
  "Return selected string or \"empty string\" if none selected."
  (interactive (if (use-region-p)
                   (list (region-beginning) (region-end))
                 (list (point-min) (point-min))))
  (let ((selection (buffer-substring-no-properties beg end)))
    (if (= (length selection) 0)
        (message "empty string")
      (progn
        (message selection)
        selection))))

(defun highlight-region-in-buffer (beg end)
  "Highlight all regions mached selected in current buffer."
  (interactive (if (use-region-p)
                   (list (region-beginning) (region-end))
                 (list (point-min) (point-min))))
  (let  ((selection (get-selected-string beg end)))
    (progn
      (message selection)
      (hlt-highlight-regexp-region (point-min) (point-max) selection))))




(require 'auto-complete)
(require 'auto-complete-config)
(global-auto-complete-mode t)





(require 'php-mode)




(require 'json-mode)


(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'interpreter-mode-alist '("node" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-jsx-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . js2-jsx-mode))
(add-to-list 'interpreter-mode-alist '("node" . js2-jsx-mode))
(setq js2-indent-switch-body t)




(require 'ac-js2)




(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.tpl\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.hbs\\'" . web-mode))
;(add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))
;(setq web-mode-content-types-alist '(("jsx" . "\\.js[x]?\\'")))

(require 'scss-mode)

(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))

(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))





(require 'highlight-indent-guides)
(setq highlight-indent-guides-auto-enabled nil)
;(set-face-background 'highlight-indent-guides-odd-face "#000000")
;(set-face-background 'highlight-indent-guides-even-face "#262626")
;(set-face-foreground 'highlight-indent-guides-character-face "#585858")
(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)


; highlight brackets
(show-paren-mode 1)




(require 'neotree)
(setq neo-window-width 40)
(setq neo-window-fixed-size nil)
(setq neo-smart-open t)




(require 'magit)




(global-undo-tree-mode)
;(global-set-key (kbd "C-<") 'undo)
;(global-set-key (kbd "C-<") 'redo)





(require 'git-gutter)
(global-git-gutter-mode t)




(require 'projectile)
(projectile-global-mode)
(setq projectile-switch-project-action 'neotree-projectile-action)




(require 'expand-region)
(global-set-key (kbd "C-^") 'er/expand-region)




; colors for neotree configuration
;(custom-set-faces
; '(col-highlight ((t (:background "#262626"))))
; '(hl-line ((t (:background "#262626"))))
; '(lazy-highlight ((t (:background "#000000" :foreground "white" :underline t))))
; '(neo-dir-link-face ((t (:foreground "cyan"))))
;'(neo-file-link-face ((t (:foreground "white")))))
;(custom-set-variables)

(defun neotree-project-dir ()
  "Open NeoTree using the git root."
  (interactive)
  (let ((project-dir (projectile-project-root))
        (file-name (buffer-file-name)))
    (if project-dir
        (if (neotree-toggle)
            (progn
              (neotree-dir project-dir)
              (neotree-find file-name)))
      (message "Could not find git project root."))))

(global-set-key [f8] 'neotree-project-dir)
;(global-set-key [f8] 'neotree-toggle)

(setq show-paren-style 'mixed) ; highlight brackets if visible, else entire expression




(global-set-key (kbd "C-x g") 'magit-status)




(global-set-key (kbd "C-x C-b") 'buffer-menu)





(setq path-to-ctags "ctags") ;; <- your ctags path here

(defun create-tags (dir-name)
    "Create tags file."
    (interactive "DDirectory: ")
    (setq ctags-exclude-config-path (getenv "ctags_exclude_config_path"))
    (setq ctags-command
          (format "%s -e -f TAGS --recurse --exclude=@%s %s"
                  path-to-ctags
                  ctags-exclude-config-path
                  (directory-file-name dir-name)))
    (shell-command ctags-command)
  )




; indent configuration
(setq ide-indent 2)
(setq-default indent-tabs-mode nil)
(setq tab-width ide-indent)
(setq js-indent-level ide-indent)
(setq web-mode-markup-indent-offset ide-indent)
(setq web-mode-css-indent-offset ide-indent)
(setq web-mode-code-indent-offset ide-indent)
(setq sh-basic-offset ide-indent)
(setq sh-indentation ide-indent)




(require 'whitespace)
(global-whitespace-mode t)
(setq whitespace-style
  '(
    face
    trailing
    tabs
    ))

(setq non-printable-colors "#262626")

(set-face-attribute 'whitespace-space nil :background "default" :foreground non-printable-colors)
(set-face-attribute 'whitespace-newline nil :background "default" :foreground non-printable-colors)
(set-face-attribute 'whitespace-tab nil :background "default" :foreground non-printable-colors)

;;; taken from http://www.emacswiki.org/emacs/MoveLineRegion
;;; requires code from http://www.emacswiki.org/emacs/MoveLine;;; and http://www.emacswiki.org/emacs/MoveRegion
(defun move-line (n)
  "Move the current line up or down by N lines."
  (interactive "p")
  (setq col (current-column))
  (beginning-of-line) (setq start (point))
  (end-of-line) (forward-char) (setq end (point))
  (let ((line-text (delete-and-extract-region start end)))
    (forward-line n)
    (insert line-text)
    ;; restore point to original column in moved line
    (forward-line -1)
    (forward-char col)))

(defun move-line-up (n)
  "Move the current line up by N lines."
  (interactive "p")
  (move-line (if (null n) -1 (- n))))

(defun move-line-down (n)
  "Move the current line down by N lines."
  (interactive "p")
  (move-line (if (null n) 1 n)))

(defun move-region (start end n)
  "Move the current region up or down by N lines."
  (interactive "r\np")
  (let ((line-text (delete-and-extract-region start end)))
    (forward-line n)
    (let ((start (point)))
      (insert line-text)
      (setq deactivate-mark nil)
      (set-mark start))))

(defun move-region-up (start end n)
  "Move the current line up by N lines."
  (interactive "r\np")
  (move-region start end (if (null n) -1 (- n))))

(defun move-region-down (start end n)
  "Move the current line down by N lines."
  (interactive "r\np")
  (move-region start end (if (null n) 1 n)))

(defun move-line-region-up (start end n)
  (interactive "r\np")
  (if (region-active-p) (move-region-up start end n) (move-line-up n)))

(defun move-line-region-down (start end n)
  (interactive "r\np")
  (if (region-active-p) (move-region-down start end n) (move-line-down n)))

(global-set-key (kbd "M-<up>") 'move-line-region-up)
(global-set-key (kbd "M-<down>") 'move-line-region-down)



(require 'ac-etags)
(eval-after-load "etags"
  '(progn
     (ac-etags-setup)))





(require 'flycheck)
;; turn on flychecking globally
(global-flycheck-mode)
(setq flycheck-check-syntax-automatically '(mode-enabled save))
;; disable jshint since we prefer eslint checking
(setq-default flycheck-disabled-checkers
              (append flycheck-disabled-checkers
                      '(javascript-jshint)))

;; disable jscs since we prefer eslint checking
(setq-default flycheck-disabled-checkers
              (append flycheck-disabled-checkers
                      '(javascript-jscs)))


;(add-hook 'sh-mode-hook 'flycheck-mode)




(defun toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
	     (next-win-buffer (window-buffer (next-window)))
	     (this-win-edges (window-edges (selected-window)))
	     (next-win-edges (window-edges (next-window)))
	     (this-win-2nd (not (and (<= (car this-win-edges)
					 (car next-win-edges))
				     (<= (cadr this-win-edges)
					 (cadr next-win-edges)))))
	     (splitter
	      (if (= (car this-win-edges)
		     (car (window-edges (next-window))))
		  'split-window-horizontally
		'split-window-vertically)))
	(delete-other-windows)
	(let ((first-win (selected-window)))
	  (funcall splitter)
	  (if this-win-2nd (other-window 1))
	  (set-window-buffer (selected-window) this-win-buffer)
	  (set-window-buffer (next-window) next-win-buffer)
	  (select-window first-win)
	  (if this-win-2nd (other-window 1))))))

(global-set-key (kbd "C-x |") 'toggle-window-split)








;; (defun search-eslint-rc ()
;;   "search eslint configurations in parent dirs and set it for flycheck"
;;   (let (
;;         (files-names
;;          '(
;;            ".eslintrc"
;;            ".eslintrc.json"))
;;         (eslintrc)
;;         (eslintrc-dir))
;;     (dolist (file-name files-names)
;;       (message "search %s" file-name)
;;       (setq eslintrc-dir (locate-dominating-file (buffer-file-name) file-name))
;;       (if eslintrc-dir
;;           (progn
;;             (setq eslintrc (concat eslintrc-dir file-name))
;;             (return)))
;;       )
;;     (if eslintrc
;;         (progn
;;           (message "eslintrc->%s" eslintrc)
;;           (setq flycheck-eslintrc eslintrc)))))

;; (add-hook 'flycheck-mode-hook 'search-eslint-rc)





(defun my/use-eslint-from-node-modules ()
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

(add-hook 'flycheck-mode-hook 'my/use-eslint-from-node-modules)

(require 'multiple-cursors)
(global-set-key (kbd "C-c m n") 'mc/mark-next-like-this)
(global-set-key (kbd "C-c m p") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c m a") 'mc/mark-all-like-this)

(delete-selection-mode t)
(electric-pair-mode t)

(defun back-to-indentation-or-beginning () (interactive)
   (if (= (point) (progn (back-to-indentation) (point)))
       (beginning-of-line)))

(global-set-key (kbd "<home>") 'back-to-indentation-or-beginning)

(setq ide-temporary-directory (getenv "ide_tmp_dir"))

(setq backup-directory-alist
      `((".*" . ,ide-temporary-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,ide-temporary-directory t)))


(add-hook 'c-mode-common-hook   'hs-minor-mode)
(add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)
(add-hook 'java-mode-hook       'hs-minor-mode)
(add-hook 'lisp-mode-hook       'hs-minor-mode)
(add-hook 'perl-mode-hook       'hs-minor-mode)
(add-hook 'sh-mode-hook         'hs-minor-mode)
(add-hook 'js-mode-hook 'hs-minor-mode)
(add-hook 'json-mode-hook       'hs-minor-mode)


(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(autoload 'gfm-mode "markdown-mode"
   "Major mode for editing GitHub Flavored Markdown files" t)
(add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))


(defun cfg:reverse-input-method (input-method)
  "Build the reverse mapping of single letters from INPUT-METHOD."
  (interactive
   (list (read-input-method-name "Use input method (default current): ")))
  (if (and input-method (symbolp input-method))
      (setq input-method (symbol-name input-method)))
  (let ((current current-input-method)
        (modifiers '(nil (control) (meta) (control meta))))
    (when input-method
      (activate-input-method input-method))
    (when (and current-input-method quail-keyboard-layout)
      (dolist (map (cdr (quail-map)))
        (let* ((to (car map))
               (from (quail-get-translation
                      (cadr map) (char-to-string to) 1)))
          (when (and (characterp from) (characterp to))
            (dolist (mod modifiers)
              (define-key local-function-key-map
                (vector (append mod (list from)))
                (vector (append mod (list to)))))))))
    (when input-method
      (activate-input-method current))))

(cfg:reverse-input-method 'russian-computer)

(provide '.emacs)
;;; .emacs ends here
