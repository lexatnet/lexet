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
	magit))

(require 'package)

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

;; highlight brackets
(show-paren-mode 1)

(require 'neotree)

(require 'magit)

(require 'projectile)

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

(setq show-paren-style 'mixed) ; highlight brackets if visible, else entire expression
