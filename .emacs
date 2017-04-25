 (add-to-list 'load-path "/tmp/emacs-packeges/")

; list the packages you want
(setq package-list '(
	auto-highlight-symbol
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
        multiple-cursors))

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

(require 'auto-highlight-symbol)
(global-auto-highlight-symbol-mode t)

(require 'auto-complete)
(require 'auto-complete-config)

(require 'php-mode)

(require 'json-mode)

(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'interpreter-mode-alist '("node" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . js2-jsx-mode))
(add-to-list 'interpreter-mode-alist '("node" . js2-jsx-mode))

(require 'ac-js2)

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.tpl\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.hbs\\'" . web-mode))

; indent configuration
(setq web-mode-markup-indent-offset 2)
(setq web-mode-css-indent-offset 2)
(setq web-mode-code-indent-offset 2)

(require 'scss-mode)

(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))

; highlight brackets
(show-paren-mode 1)

(require 'neotree)

(require 'magit)

(require 'git-gutter)

(require 'projectile)

(setq neo-smart-open t)
; colors for neotree configuration
(custom-set-faces
 '(col-highlight ((t (:background "color-233"))))
 '(hl-line ((t (:background "color-233"))))
 '(lazy-highlight ((t (:background "black" :foreground "white" :underline t))))
 '(neo-dir-link-face ((t (:foreground "cyan"))))
 '(neo-file-link-face ((t (:foreground "white")))))
(custom-set-variables)

(setq neo-window-width 40)
(setq neo-window-fixed-size nil)

(projectile-global-mode)

(setq projectile-switch-project-action 'neotree-projectile-action)

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

(global-git-gutter-mode t)

(global-set-key (kbd "C-x g") 'magit-status)

(global-set-key (kbd "C-x C-g") 'git-gutter)

(global-set-key "\C-x\C-b" 'buffer-menu)

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

(global-auto-complete-mode t)

(setq-default indent-tabs-mode nil)
(setq tab-width 2)
(setq js-indent-level 2)
(require 'whitespace)

(global-whitespace-mode t)

(setq whitespace-style
  '(
    face
    tab-mark
    newline
    newline-mark
))

(set-face-attribute 'whitespace-space nil :background "default" :foreground "white")
(set-face-attribute 'whitespace-newline nil :background "default" :foreground "white")
(set-face-attribute 'whitespace-tab nil :background "default" :foreground "white")

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


;; make ctrl-z undo
(global-set-key (kbd "C-z") 'undo)

(global-undo-tree-mode)

(require 'ac-etags)
(eval-after-load "etags"
  '(progn
      (ac-etags-setup)))

(require 'flycheck)
;; turn on flychecking globally
(global-flycheck-mode)
(setq flycheck-check-syntax-automatically '(mode-enabled save))
;; disable jshint since we prefer eslint checking
;; (setq-default flycheck-disabled-checkers
;;   (append flycheck-disabled-checkers
;;           '(javascript-jshint)))

;; use local eslint from node_modules before global
;; http://emacs.stackexchange.com/questions/21205/flycheck-with-file-relative-eslint-executable
(defun my/use-eslint-from-node-modules ()
  (let* ((root (locate-dominating-file
                (or (buffer-file-name) default-directory)
                "node_modules"))
         (eslint (and root
                      (expand-file-name "node_modules/eslint/bin/eslint.js"
                                        root))))
    (when (and eslint (file-executable-p eslint))
      (setq-local flycheck-javascript-eslint-executable eslint))))
(add-hook 'flycheck-mode-hook #'my/use-eslint-from-node-modules)

(require 'multiple-cursors)

(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
