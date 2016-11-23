(add-to-list 'load-path "/tmp/emacs-packeges/")

; list the packages you want
(setq package-list '(
	auto-complete 
	php-mode
	web-mode
	ac-php))

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

(require 'auto-complete)
(require 'auto-complete-config)

(require 'php-mode)

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.tpl\\'" . web-mode))

;; highlight brackets
(show-paren-mode 1)

(setq show-paren-style 'mixed) ; highlight brackets if visible, else entire expression

