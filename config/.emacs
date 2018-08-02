;;; package --- Summary
;;; Commentary:
;;; Code:
(setq package-user-dir (getenv "lexet_packages_dir"))

(menu-bar-mode -1)
(tool-bar-mode -1)
(setq inhibit-startup-screen t)

(setq-default frame-title-format (format "lexet - %s@%s" (getenv "project_name") "%f"))

(load-theme 'tango-dark)

; list the packages you want
(setq package-list
      '(
        helm
        helm-flyspell
        highlight
        highlight-symbol
        auto-complete
	ac-helm
        php-mode
        web-mode
        ac-php
        json-mode
        js2-mode
        ac-js2
        projectile
        helm-projectile
        neotree
        magit
        git-gutter
        scss-mode
        flycheck
        helm-flycheck
        ac-etags
        el-get
        undo-tree
        multiple-cursors
        highlight-indent-guides
        yaml-mode
        expand-region
        markdown-mode
        async
        sql-indent
        smartparens
        hydra
        use-package
        smart-mode-line
        powerline
        treemacs
        winum))

(require 'package)

;(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") )

(add-to-list  'package-archives '("melpa" . "https://melpa.org/packages/") )

(add-to-list  'package-archives '("gnu" . "https://elpa.gnu.org/packages/") )

;(add-to-list  'package-archives '("marmalade" . "https://marmalade-repo.org/packages/") )

(package-initialize)

; fetch the list of packages available
(unless package-archive-contents
 (package-refresh-contents))
;; (package-refresh-contents)

; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(eval-when-compile
  ;; Following line is not needed if use-package.el is in ~/.emacs.d
  ;; (add-to-list 'load-path "<path where use-package is installed>")
  (require 'use-package))



(require 'el-get)

(require 'hydra)

(require 'helm)
(require 'helm-config)
(global-set-key (kbd "M-x") 'helm-M-x)



;enable flspell-mode for text modes
(dolist (hook '(text-mode-hook))
  (add-hook hook (lambda () (flyspell-mode 1))))

(dolist (mode '(emacs-lisp-mode-hook
                python-mode-hook
                js-mode-hook
                ruby-mode-hook
                php-mode-hook
                sh-mode-hook))
  (add-hook mode
            '(lambda ()
               (flyspell-prog-mode)
	       (define-key flyspell-mode-map (kbd "C-;") 'helm-flyspell-correct))))




(require 'highlight-symbol)
(dolist (mode '(prog-mode-hook
                text-mode-hook))
  (add-hook mode
            '(lambda ()
               (highlight-symbol-mode))))

(global-set-key (kbd "M-<right>") 'highlight-symbol-next)
(global-set-key (kbd "M-<left>") 'highlight-symbol-prev)




;(require 'zones)



(require 'highlight)
(global-set-key (kbd "C-c h a") 'hlt-unhighlight-all-prop)
(global-set-key (kbd "C-c h s") 'highlight-region-in-buffer)
(global-set-key (kbd "C-c h n") 'hlt-next-highlight)
(global-set-key (kbd "C-c h p") 'hlt-previous-highlight)

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
(ac-config-default)
(global-auto-complete-mode t)
(setq ac-disable-faces nil)
;(setq ac-auto-start 3)

(require 'ac-helm)  ;; Not necessary if using ELPA package
(global-set-key (kbd "C-:") 'ac-complete-with-helm)
(define-key ac-complete-mode-map (kbd "C-:") 'ac-complete-with-helm)




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
  (let* (
         (tag-file-name (lexet-generate-tags-filename file))
         (tag-file-directory (file-name-directory tag-file-name))
         )
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


(require 'php-mode)
(add-hook 'php-mode-hook 'php-enable-default-coding-style)
(eval-after-load 'php-mode
  '(require 'php-ext))

(add-hook 'php-mode-hook
            '(lambda ()
               (require 'ac-php)
               (setq ac-sources  '(ac-source-php ) )
               (yas-global-mode 1)
               (ac-php-core-eldoc-setup ) ;; enable eldoc

               (define-key php-mode-map  (kbd "C-]") 'ac-php-find-symbol-at-point)   ;goto define
               (define-key php-mode-map  (kbd "C-t") 'ac-php-location-stack-back)    ;go back
               ))



(require 'json-mode)


(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'interpreter-mode-alist '("node" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-jsx-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . js2-jsx-mode))
(add-to-list 'interpreter-mode-alist '("node" . js2-jsx-mode))
(setq js2-indent-switch-body t)




(require 'ac-js2)

(dolist (mode '(js-mode-hook))
  (add-hook mode
            '(lambda ()
               (ac-js2-mode))))




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
(setq highlight-indent-guides-method 'fill)
(setq highlight-indent-guides-responsive nil)
;(setq highlight-indent-guides-auto-enabled nil)
;(setq highlight-indent-guides-responsive 'top)
(setq highlight-indent-guides-auto-odd-face-perc 2)
(setq highlight-indent-guides-auto-even-face-perc 0)
;(setq highlight-indent-guides-auto-character-face-perc 20)
;(set-face-background 'highlight-indent-guides-odd-face "#000000")
;(set-face-background 'highlight-indent-guides-even-face "#262626")
;(set-face-foreground 'highlight-indent-guides-character-face "#585858")
(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)


;; highlight brackets
;; (show-paren-mode 1)
;; (setq show-paren-delay 0)
;; (setq show-paren-style 'mixed) ; highlight brackets if visible, else entire expression



(require 'neotree)
;; (setq neo-window-width 40)
(setq neo-window-fixed-size nil)
;; (setq neo-smart-open t)




(require 'magit)




(global-undo-tree-mode)
;(global-set-key (kbd "C-<") 'undo)
;(global-set-key (kbd "C-<") 'redo)





(require 'git-gutter)
(global-git-gutter-mode t)

(global-set-key (kbd "C-c g u") 'git-gutter:popup-hunk)

;; Jump to next/previous hunk
(global-set-key (kbd "C-c g p") 'git-gutter:previous-hunk)
(global-set-key (kbd "C-c g n") 'git-gutter:next-hunk)

;; Stage current hunk
(global-set-key (kbd "C-c g s") 'git-gutter:stage-hunk)

;; Revert current hunk
(global-set-key (kbd "C-c g r") 'git-gutter:revert-hunk)

;; Mark current hunk
(global-set-key (kbd "C-c g m") #'git-gutter:mark-hunk)




(require 'projectile)
(projectile-global-mode)
(setq projectile-switch-project-action 'neotree-projectile-action)
(setq projectile-completion-system 'helm)
(require 'helm-projectile)
(helm-projectile-on)




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



(eval-after-load "sql"
  '(load-library "sql-indent"))


; indent configuration
(setq lexet-indent 2)
(setq-default indent-tabs-mode nil)
(setq default-tab-width lexet-indent)
(setq tab-width lexet-indent)
(setq js-indent-level lexet-indent)
(setq web-mode-markup-indent-offset lexet-indent)
(setq web-mode-css-indent-offset lexet-indent)
(setq web-mode-code-indent-offset lexet-indent)
(setq sh-basic-offset lexet-indent)
(setq sh-indentation lexet-indent)
(setq python-indent-offset lexet-indent)
(setq sql-indent-offset lexet-indent)





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
(custom-set-variables
 '(ac-etags-requires 1))

(eval-after-load "etags"
  '(progn
     (ac-etags-setup)))

(defun lexet-ac-setup-source-etags ()
  (setq ac-sources (append ac-sources '(ac-source-etags))))

(dolist (mode '(c-mode-common-hook
                json-mode-hook
                emacs-lisp-mode-hook
                python-mode-hook
                js-mode-hook
                ruby-mode-hook
                php-mode-hook
                sh-mode-hook))
  (add-hook mode
            '(lambda ()
               (lexet-ac-setup-source-etags))))



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
(setq flycheck-shellcheck-follow-sources nil)
(setq flycheck-python-pylint-executable "pylint3")

(setq-default flycheck-disabled-checkers
              (append flycheck-disabled-checkers
                      '(ruby-rubylint)))




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





(autoload 'ruby-mode "ruby-mode" "Major mode for ruby files" t)
(add-to-list 'auto-mode-alist
               '("\\.\\(?:cap\\|gemspec\\|irbrc\\|gemrc\\|rake\\|rb\\|ru\\|thor\\)\\'" . ruby-mode))
(add-to-list 'auto-mode-alist
               '("\\(?:Brewfile\\|Capfile\\|Gemfile\\(?:\\.[a-zA-Z0-9._-]+\\)?\\|[rR]akefile\\)\\'" . ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))





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

;; (electric-pair-mode t)
(smartparens-global-mode 1)
(require 'smartparens-config)
;;;;;;;;;;;;;;;;;;;;;;;;
;; keybinding management
(define-key smartparens-mode-map (kbd "C-M-f") 'sp-forward-sexp)
(define-key smartparens-mode-map (kbd "C-M-b") 'sp-backward-sexp)

(define-key smartparens-mode-map (kbd "C-M-d") 'sp-down-sexp)
(define-key smartparens-mode-map (kbd "C-M-a") 'sp-backward-down-sexp)
(define-key smartparens-mode-map (kbd "C-S-d") 'sp-beginning-of-sexp)
(define-key smartparens-mode-map (kbd "C-S-a") 'sp-end-of-sexp)

(define-key smartparens-mode-map (kbd "C-M-e") 'sp-up-sexp)
(define-key smartparens-mode-map (kbd "C-M-u") 'sp-backward-up-sexp)
(define-key smartparens-mode-map (kbd "C-M-t") 'sp-transpose-sexp)

(define-key smartparens-mode-map (kbd "C-M-n") 'sp-forward-hybrid-sexp)
(define-key smartparens-mode-map (kbd "C-M-p") 'sp-backward-hybrid-sexp)

(define-key smartparens-mode-map (kbd "C-M-k") 'sp-kill-sexp)
(define-key smartparens-mode-map (kbd "C-M-w") 'sp-copy-sexp)

(define-key smartparens-mode-map (kbd "M-<delete>") 'sp-unwrap-sexp)
(define-key smartparens-mode-map (kbd "M-<backspace>") 'sp-backward-unwrap-sexp)

(define-key smartparens-mode-map (kbd "C-<right>") 'sp-forward-slurp-sexp)
(define-key smartparens-mode-map (kbd "C-<left>") 'sp-forward-barf-sexp)
(define-key smartparens-mode-map (kbd "C-M-<left>") 'sp-backward-slurp-sexp)
(define-key smartparens-mode-map (kbd "C-M-<right>") 'sp-backward-barf-sexp)

(define-key smartparens-mode-map (kbd "M-D") 'sp-splice-sexp)
(define-key smartparens-mode-map (kbd "C-M-<delete>") 'sp-splice-sexp-killing-forward)
(define-key smartparens-mode-map (kbd "C-M-<backspace>") 'sp-splice-sexp-killing-backward)
(define-key smartparens-mode-map (kbd "C-S-<backspace>") 'sp-splice-sexp-killing-around)

(define-key smartparens-mode-map (kbd "C-]") 'sp-select-next-thing-exchange)
(define-key smartparens-mode-map (kbd "C-<left_bracket>") 'sp-select-previous-thing)
(define-key smartparens-mode-map (kbd "C-M-]") 'sp-select-next-thing)

(define-key smartparens-mode-map (kbd "M-F") 'sp-forward-symbol)
(define-key smartparens-mode-map (kbd "M-B") 'sp-backward-symbol)

(define-key smartparens-mode-map (kbd "C-\"") 'sp-change-inner)

(bind-key "C-c f" (lambda () (interactive) (sp-beginning-of-sexp 2)) smartparens-mode-map)
(bind-key "C-c b" (lambda () (interactive) (sp-beginning-of-sexp -2)) smartparens-mode-map)

(bind-key "C-M-s"
          (defhydra smartparens-hydra ()
            "Smartparens"
            ("d" sp-down-sexp "Down")
            ("e" sp-up-sexp "Up")
            ("u" sp-backward-up-sexp "Up")
            ("a" sp-backward-down-sexp "Down")
            ("f" sp-forward-sexp "Forward")
            ("b" sp-backward-sexp "Backward")
            ("k" sp-kill-sexp "Kill" :color blue)
            ("q" nil "Quit" :color blue))
          smartparens-mode-map)

(bind-key "H-t" 'sp-prefix-tag-object smartparens-mode-map)
(bind-key "H-p" 'sp-prefix-pair-object smartparens-mode-map)
(bind-key "H-y" 'sp-prefix-symbol-object smartparens-mode-map)
(bind-key "H-h" 'sp-highlight-current-sexp smartparens-mode-map)
(bind-key "H-e" 'sp-prefix-save-excursion smartparens-mode-map)
(bind-key "H-s c" 'sp-convolute-sexp smartparens-mode-map)
(bind-key "H-s a" 'sp-absorb-sexp smartparens-mode-map)
(bind-key "H-s e" 'sp-emit-sexp smartparens-mode-map)
(bind-key "H-s p" 'sp-add-to-previous-sexp smartparens-mode-map)
(bind-key "H-s n" 'sp-add-to-next-sexp smartparens-mode-map)
(bind-key "H-s j" 'sp-join-sexp smartparens-mode-map)
(bind-key "H-s s" 'sp-split-sexp smartparens-mode-map)
(bind-key "H-s r" 'sp-rewrap-sexp smartparens-mode-map)
(defvar hyp-s-x-map)
(define-prefix-command 'hyp-s-x-map)
(bind-key "H-s x" hyp-s-x-map smartparens-mode-map)
(bind-key "H-s x x" 'sp-extract-before-sexp smartparens-mode-map)
(bind-key "H-s x a" 'sp-extract-after-sexp smartparens-mode-map)
(bind-key "H-s x s" 'sp-swap-enclosing-sexp smartparens-mode-map)

(bind-key "C-x C-t" 'sp-transpose-hybrid-sexp smartparens-mode-map)

(bind-key ";" 'sp-comment emacs-lisp-mode-map)

(bind-key [remap c-electric-backspace] 'sp-backward-delete-char smartparens-strict-mode-map)

;;;;;;;;;;;;;;;;;;
;; pair management

(sp-local-pair 'minibuffer-inactive-mode "'" nil :actions nil)
(bind-key "C-(" 'sp---wrap-with-40 minibuffer-local-map)

;;; rst-mode
(sp-with-modes 'rst-mode
  (sp-local-pair "*" "*"
                 :wrap "C-*"
                 :unless '(sp--gfm-point-after-word-p sp-point-at-bol-p)
                 :post-handlers '(("[d1]" "SPC"))
                 :skip-match 'sp--gfm-skip-asterisk)
  (sp-local-pair "**" "**")
  (sp-local-pair "_" "_" :wrap "C-_" :unless '(sp-point-after-word-p))
  (sp-local-pair "``" "``"))

;;; tex-mode latex-mode
(sp-with-modes '(tex-mode plain-tex-mode latex-mode)
  (sp-local-tag "i" "\"<" "\">"))

;;; lisp modes
(sp-with-modes sp--lisp-modes
  (sp-local-pair "(" nil
                 :wrap "C-("
                 :pre-handlers '(my-add-space-before-sexp-insertion)
                 :post-handlers '(my-add-space-after-sexp-insertion)))

(defun my-add-space-after-sexp-insertion (id action _context)
  (when (eq action 'insert)
    (save-excursion
      (forward-char (sp-get-pair id :cl-l))
      (when (or (eq (char-syntax (following-char)) ?w)
                (looking-at (sp--get-opening-regexp)))
        (insert " ")))))

(defun my-add-space-before-sexp-insertion (id action _context)
  (when (eq action 'insert)
    (save-excursion
      (backward-char (length id))
      (when (or (eq (char-syntax (preceding-char)) ?w)
                (and (looking-back (sp--get-closing-regexp))
                     (not (eq (char-syntax (preceding-char)) ?'))))
        (insert " ")))))

;;; C++
(sp-with-modes '(malabar-mode c++-mode)
  (sp-local-pair "{" nil :post-handlers '(("||\n[i]" "RET"))))
(sp-local-pair 'c++-mode "/*" "*/" :post-handlers '((" | " "SPC")
                                                    ("* ||\n[i]" "RET")))

;;; PHP
(sp-with-modes '(php-mode)
  (sp-local-pair "/**" "*/" :post-handlers '(("| " "SPC")
                                             (my-php-handle-docstring "RET")))
  (sp-local-pair "/*." ".*/" :post-handlers '(("| " "SPC")))
  (sp-local-pair "{" nil :post-handlers '(("||\n[i]" "RET") my-php-wrap-handler))
  (sp-local-pair "(" nil :prefix "\\(\\sw\\|\\s_\\)*"))

(defun my-php-wrap-handler (&rest _ignored)
  (save-excursion
    (sp-get sp-last-wrapped-region
      (goto-char :beg-in)
      (unless (looking-at "[ \t]*$")
        (newline-and-indent))
      (goto-char :end-in)
      (beginning-of-line)
      (unless (looking-at "[ \t]*}[ \t]*$")
        (goto-char :end-in)
        (newline-and-indent))
      (indent-region :beg-prf :end-suf))))

(defun my-php-handle-docstring (&rest _ignored)
  (-when-let (line (save-excursion
                     (forward-line)
                     (thing-at-point 'line)))
    (cond
     ;; variable
     ((string-match (rx (or "private" "protected" "public" "var") (1+ " ") (group "$" (1+ alnum))) line)
      (let ((var-name (match-string 1 line))
            (type ""))
        ;; try to guess the type from the constructor
        (-when-let (constructor-args (my-php-get-function-args "__construct" t))
          (setq type (or (cdr (assoc var-name constructor-args)) "")))
        (insert "* @var " type)
        (save-excursion
          (insert "\n"))))
     ((string-match-p "function" line)
      (save-excursion
        (let ((args (save-excursion
                      (forward-line)
                      (my-php-get-function-args nil t))))
          (--each args
            (when (my-php-should-insert-type-annotation (cdr it))
              (insert (format "* @param %s%s\n"
                              (my-php-translate-type-annotation (cdr it))
                              (car it))))))
        (let ((return-type (save-excursion
                             (forward-line)
                             (my-php-get-function-return-type))))
          (when (my-php-should-insert-type-annotation return-type)
            (insert (format "* @return %s\n" (my-php-translate-type-annotation return-type))))))
      (re-search-forward (rx "@" (or "param" "return") " ") nil t))
     ((string-match-p ".*class\\|interface" line)
      (save-excursion (insert "\n"))
      (insert "* ")))
    (let ((o (sp--get-active-overlay)))
      (indent-region (overlay-start o) (overlay-end o)))))

;; (defface sp-pair-overlay-face
;;   '((t (:inherit highlight)))
;;   "The face used to highlight pair overlays."
;;   :group 'smartparens)

;; (defface sp-wrap-overlay-face
;;   '((t (:inherit sp-pair-overlay-face)))
;;   "The face used to highlight wrap overlays."
;;   :group 'smartparens)

;; (defface sp-wrap-tag-overlay-face
;;   '((t (:inherit sp-pair-overlay-face)))
;;   "The face used to highlight wrap tag overlays."
;;   :group 'smartparens)


(show-smartparens-global-mode t)

;; -----------------------------------------------------

(defun back-to-indentation-or-beginning () (interactive)
   (if (= (point) (progn (back-to-indentation) (point)))
       (beginning-of-line)))

(global-set-key (kbd "<home>") 'back-to-indentation-or-beginning)





(setq lexet-temporary-directory (getenv "lexet_tmp_dir"))




(setq backup-directory-alist
      `((".*" . ,lexet-temporary-directory)))



(setq auto-save-file-name-transforms
      `((".*" ,lexet-temporary-directory t)))



; show/hide blocks
(dolist (mode '(c-mode-common-hook
		emacs-lisp-mode-hook
		java-mode-hook
		lisp-mode-hook
		perl-mode-hook
		sh-mode-hook
		js-mode-hook
		json-mode-hook
		ruby-mode-hook))
  (add-hook mode
            '(lambda ()
               (hs-minor-mode))))


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




(global-auto-revert-mode t)
(global-hl-line-mode +1)
(set-face-attribute 'hl-line nil :inherit nil :background "#4d4927")



(if (boundp 'lexet-tags-root)
    (progn
      (if (file-exists-p lexet-tags-root)
          (delete-directory lexet-tags-root t))
      (lexet-tags-indexation)
      (add-hook 'after-save-hook (lambda ()
                                   (lexet-run-file-indexation (file-relative-name buffer-file-name (projectile-project-root)))))))



(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (setq treemacs-collapse-dirs              (if (executable-find "python") 3 0)
          treemacs-deferred-git-apply-delay   0.5
          treemacs-file-event-delay           5000
          treemacs-file-follow-delay          0.2
          treemacs-follow-after-init          t
          treemacs-follow-recenter-distance   0.1
          treemacs-goto-tag-strategy          'refetch-index
          treemacs-indentation                2
          treemacs-indentation-string         " "
          treemacs-is-never-other-window      nil
          treemacs-no-png-images              nil
          treemacs-project-follow-cleanup     nil
          treemacs-persist-file               (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
          treemacs-recenter-after-file-follow nil
          treemacs-recenter-after-tag-follow  nil
          treemacs-show-hidden-files          t
          treemacs-silent-filewatch           nil
          treemacs-silent-refresh             nil
          treemacs-sorting                    'alphabetic-desc
          treemacs-space-between-root-nodes   t
          treemacs-tag-follow-cleanup         t
          treemacs-tag-follow-delay           1.5
          treemacs-width                      35)

    ;; The default width and height of the icons is 22 pixels. If you are
    ;; using a Hi-DPI display, uncomment this to double the icon size.
    ;;(treemacs-resize-icons 44)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode t)
    (pcase (cons (not (null (executable-find "git")))
                 (not (null (executable-find "python3"))))
      (`(t . t)
       (treemacs-git-mode 'extended))
      (`(t . _)
       (treemacs-git-mode 'simple))))
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-projectile
  :after treemacs projectile
  :ensure t)



;; (use-package smart-mode-line-powerline-theme
;;    :ensure t
;;    :after powerline
;;    :after smart-mode-line
;;    :config
;;    (setq sml/theme 'powerline)
;;    (setq sml/no-confirm-load-theme t)
;;    (sml/setup)
;;    ;; (sml/apply-theme 'powerline)
;;    )

(column-number-mode)
(setq sml/theme 'powerline)
(setq sml/no-confirm-load-theme t)
(sml/setup)

;(tags-completion-table)
(provide '.emacs)
;;; .emacs ends here
