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
	ac-etags))

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

(require 'auto-highlight-symbol)
(global-auto-highlight-symbol-mode t)

(require 'auto-complete)
(require 'auto-complete-config)

(require 'php-mode)

(require 'json-mode)
(require 'js2-mode)
(require 'ac-js2)

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.tpl\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))

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

(setq path-to-ctags "/usr/bin/ctags") ;; <- your ctags path here

(defun create-tags (dir-name)
    "Create tags file."
    (interactive "DDirectory: ")
    (shell-command
     (format "%s -f TAGS -e -R --exclude=.git/* --exclude=node_modules/* %s" path-to-ctags (directory-file-name dir-name)))
  )

(global-auto-complete-mode t)
