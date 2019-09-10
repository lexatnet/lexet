
;;; package --- Summary
;;; Commentary:
;;; Code:
(add-to-list 'load-path (getenv "lexet_packages_dir"))
(setq package-user-dir (getenv "lexet_vendor_packages_dir"))

(menu-bar-mode 0)
(tool-bar-mode 0)
(delete-selection-mode t)
(global-auto-revert-mode t)
(defalias 'yes-or-no-p 'y-or-n-p)
(setq column-number-mode t)
(setq tags-revert-without-query 1)
(setq inhibit-startup-screen t)

(setq-default frame-title-format (format "lexet - %s@%s" (getenv "project_name") "%f"))

(setq lexet-temporary-directory (getenv "lexet_tmp_dir"))
(setq backup-directory-alist
      `((".*" . ,lexet-temporary-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,lexet-temporary-directory t)))

(load-theme 'tango-dark)
(global-hl-line-mode +1)
(set-face-attribute 'hl-line nil :inherit nil :background "#4d4927")

;base list of packages
(setq package-list
      '(
        js2-mode
        helm-flycheck
        el-get
        async
        sql-indent
        use-package
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

(use-package el-get
  :ensure t)

(use-package hydra
  :ensure t)

(use-package helm
  :ensure t
  :config
  (require 'helm-config)
  :bind (("M-x" . helm-M-x)))

;; enable flspell-mode for text modes
(use-package flyspell
  :hook ((emacs-lisp-mode . flyspell-prog-mode)
         (python-mode . flyspell-prog-mode)
         (js-mode . flyspell-prog-mode)
         (ruby-mode . flyspell-prog-mode)
         (php-mode . flyspell-prog-mode)
         (sh-mode . flyspell-prog-mode)
         (text-mode . flyspell-mode))
  :bind (
         :map flyspell-mode-map
         ("C-;" . helm-flyspell-correct)))

(use-package helm-flyspell
  :ensure t
  :after (helm flyspell)
  :bind (
         :map flyspell-mode-map
         ("M-S" . helm-flyspell-correct)))

(use-package highlight-symbol
  :ensure t
  :hook ((prog-mode . highlight-symbol-mode)
         (text-mode . highlight-symbol-mode))
  :bind (("M-<right>" . highlight-symbol-next)
         ("M-<left>" . highlight-symbol-prev)))

;; (use-package zones)

(use-package highlight
  :ensure t
  :init
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

  :bind (("C-c h a" . hlt-unhighlight-all-prop)
         ("C-c h s" . highlight-region-in-buffer)
         ("C-c h n" . hlt-next-highlight)
         ("C-c h p" . hlt-previous-highlight)))

(use-package auto-complete
  :ensure t
  :config
  (require 'auto-complete-config)
  (ac-config-default)
  (global-auto-complete-mode t)
  (setq ac-disable-faces nil)
  ;; (setq ac-auto-start 3)
  )

(use-package ac-helm
  :ensure t
  :after (helm auto-complete)
  :init
  :bind (
         :map ac-complete-mode-map
         ("C-c c" . ac-complete-with-helm)))

(use-package php-mode
  :ensure t
  :config
  :init
  (defun lexet-php-mode-init ())
  (eval-after-load 'php-mode
    '(require 'php-ext))
  :hook ((php-mode . php-enable-default-coding-style)
         (php-mode . lexet-php-mode-init)))

(use-package ac-php
  :ensure t
  :bind (
         ;; goto define
         ("C-]" . ac-php-find-symbol-at-point)
         ;; go back
         ("C-t" . ac-php-location-stack-back))
  :config
  (setq ac-sources (append ac-sources '(ac-source-php)))
  (ac-php-core-eldoc-setup ))

(use-package yasnippet
  :ensure t
  :commands (yas-minor-mode)
  :hook ((prog-mode . yas-minor-mode))
  :config
  (yas-reload-all))

(use-package yasnippet-snippets
  :ensure t
  :after (yasnippet))

(use-package json-mode
  :ensure t)

(use-package js2-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
  (add-to-list 'interpreter-mode-alist '("node" . js2-mode))
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-jsx-mode))
  (add-to-list 'auto-mode-alist '("\\.jsx\\'" . js2-jsx-mode))
  (add-to-list 'interpreter-mode-alist '("node" . js2-jsx-mode))
  (setq js2-indent-switch-body t))

(use-package ac-js2
  :ensure t
  :hook ((js-mode . ac-js2-mode)))

;; TypeScript
(use-package typescript-mode
  :ensure t
  :mode (("\\.ts\\'" . typescript-mode)
         ("\\.tsx\\'" . typescript-mode)))

(use-package vue-mode
  :ensure t
  :config (add-to-list 'auto-mode-alist '("\\.vue\\'" . vue-mode)))

(use-package web-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.tpl\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.hbs\\'" . web-mode))
  ;; (add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))
  ;; (setq web-mode-content-types-alist '(("jsx" . "\\.js[x]?\\'")))
  )

(use-package scss-mode
  :ensure t
  :config
  :mode (("\\.scss\\'" . scss-mode)))

(use-package yaml-mode
  :ensure t
  :config
  :mode (("\\.yml\\'" . yaml-mode)))

(use-package highlight-indent-guides
  :ensure t
  :config
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
  (add-hook 'text-mode-hook 'highlight-indent-guides-mode)
  (add-hook 'html-mode-hook 'highlight-indent-guides-mode))

(use-package neotree
  :ensure t
  :config
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
  ;; (setq neo-window-width 40)
  ;; (setq neo-window-fixed-size nil)
  ;; (setq neo-smart-open t)


  ;; colors for neotree configuration
  ;; (custom-set-faces
  ;;  '(col-highlight ((t (:background "#262626"))))
  ;;  '(hl-line ((t (:background "#262626"))))
  ;;  '(lazy-highlight ((t (:background "#000000" :foreground "white" :underline t))))
  ;;  '(neo-dir-link-face ((t (:foreground "cyan"))))
  ;;  '(neo-file-link-face ((t (:foreground "white")))))
  ;; (custom-set-variables)

  ;; (global-set-key [f8] 'neotree-toggle)

  :bind(([f8] . neotree-project-dir))
  )

(use-package magit
  :ensure t
  :bind(("C-x g" . magit-status)))

(use-package undo-tree
  :ensure t
  :config
  (global-undo-tree-mode t)
  ;; (global-set-key (kbd "C-<") 'undo)
  ;; (global-set-key (kbd "C-<") 'redo)
  )

(use-package git-gutter
  :ensure t
  :init
  (global-git-gutter-mode t)
  :bind (
         ;; Show current hunk
         ("C-c g u" . git-gutter:popup-hunk)

         ;; Jump to next/previous hunk
         ("C-c g p" . git-gutter:previous-hunk)
         ("C-c g n" . git-gutter:next-hunk)

         ;; Stage current hunk
         ("C-c g s" . git-gutter:stage-hunk)

         ;; Revert current hunk
         ("C-c g r" . git-gutter:revert-hunk)

         ;; Mark current hunk
         ("C-c g m" . git-gutter:mark-hunk)))

(use-package projectile
  :ensure t
  :config
  (projectile-global-mode)
  (setq projectile-switch-project-action 'neotree-projectile-action))

(use-package helm-projectile
  :ensure t
  ;; :after (projectile helm)
  :config
  (setq projectile-completion-system 'helm)
  (helm-projectile-on))

(use-package expand-region
  :ensure t
  :bind (("C-^" . er/expand-region)))

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
    (shell-command ctags-command))

(eval-after-load "sql"
  '(load-library "sql-indent"))

(use-package whitespace
  :config
  (global-whitespace-mode t)
  (setq whitespace-style
        '(
          face
          trailing
          tabs
          ))

  (setq non-printable-colors "#262626")

  (set-face-attribute 'whitespace-space nil :foreground non-printable-colors)
  (set-face-attribute 'whitespace-newline nil :foreground non-printable-colors)
  (set-face-attribute 'whitespace-tab nil :foreground non-printable-colors)

  ;; backup
  ;; (set-face-attribute 'whitespace-space nil :background "default" :foreground non-printable-colors)
  ;; (set-face-attribute 'whitespace-newline nil :background "default" :foreground non-printable-colors)
  ;; (set-face-attribute 'whitespace-tab nil :background "default" :foreground non-printable-colors)
  )

(use-package etags)

(use-package ac-etags
  :ensure t
  ;; :after (etags)
  :custom
  (ac-etags-requires 1)
  :hook ((c-mode-common . lexet-ac-setup-source-etags)
         (json-mode . lexet-ac-setup-source-etags)
         (emacs-lisp-mode . lexet-ac-setup-source-etags)
         (lisp-mode . lexet-ac-setup-source-etags)
         (lisp-interaction-mode . lexet-ac-setup-source-etags)
         (python-mode . lexet-ac-setup-source-etags)
         (js-mode . lexet-ac-setup-source-etags)
         (ruby-mode . lexet-ac-setup-source-etags)
         (php-mode . lexet-ac-setup-source-etags)
         (sh-mode . lexet-ac-setup-source-etags))
  :init
  (ac-etags-setup)
  (defun lexet-ac-setup-source-etags ()
    (print "lexet-ac-setup-source-etags call")
    (setq ac-sources (append ac-sources '(ac-source-etags)))))

(use-package flycheck
  :ensure t
  :config
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

  ;; (add-hook 'sh-mode-hook 'flycheck-mode)
  (setq flycheck-shellcheck-follow-sources nil)
  (setq flycheck-python-pylint-executable "pylint3")

  (setq-default flycheck-disabled-checkers
                (append flycheck-disabled-checkers
                        '(ruby-rubylint))))

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

(use-package ruby-mode
  :mode (("\\.\\(?:cap\\|gemspec\\|irbrc\\|gemrc\\|rake\\|rb\\|ru\\|thor\\)\\'" . ruby-mode)
         ("\\(?:Brewfile\\|Capfile\\|Gemfile\\(?:\\.[a-zA-Z0-9._-]+\\)?\\|[rR]akefile\\)\\'" . ruby-mode))
  :interpreter ("ruby" . ruby-mode))

(use-package multiple-cursors
  :ensure t
  :bind (("C-c m n" . mc/mark-next-like-this)
         ("C-c m p" . mc/mark-previous-like-this)
         ("C-c m a" . mc/mark-all-like-this)))

;; (electric-pair-mode t)
(use-package smartparens
  :ensure t
  :bind
  ;;;;;;;;;;;;;;;;;;;;;;;;
  ;; keybinding management
  (
   :map smartparens-mode-map
   ("C-M-f" . sp-forward-sexp)
   ("C-M-b" . sp-backward-sexp)
   ("C-M-d" . sp-down-sexp)
   ("C-M-a" . sp-backward-down-sexp)
   ("C-S-d" . sp-beginning-of-sexp)
   ("C-S-a" . sp-end-of-sexp)

   ("C-M-e" . sp-up-sexp)
   ("C-M-u" . sp-backward-up-sexp)
   ("C-M-t" . sp-transpose-sexp)

   ("C-M-n" . sp-forward-hybrid-sexp)
   ("C-M-p" . sp-backward-hybrid-sexp)

   ("C-M-k" . sp-kill-sexp)
   ("C-M-w" . sp-copy-sexp)

   ("M-<delete>" . sp-unwrap-sexp)
   ("M-<backspace>" . sp-backward-unwrap-sexp)

   ;; ("C-<right>" . sp-forward-slurp-sexp)
   ;; ("C-<left>" . sp-forward-barf-sexp)
   ;; ("C-M-<left>" . sp-backward-slurp-sexp)
   ;; ("C-M-<right>" . sp-backward-barf-sexp)

   ("M-D" . sp-splice-sexp)
   ;; ("C-M-<delete>" . sp-splice-sexp-killing-forward)
   ;; ("C-M-<backspace>" . sp-splice-sexp-killing-backward)
   ;; ("C-S-<backspace>" . sp-splice-sexp-killing-around)

   ("C-]" . sp-select-next-thing-exchange)
   ("C-<left_bracket>" . sp-select-previous-thing)
   ("C-M-]" . sp-select-next-thing)

   ("M-F" . sp-forward-symbol)
   ("M-B" . sp-backward-symbol)

   ("C-\"" . sp-change-inner))

  :config
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
              ("r" sp-rewrap-sexp "Re-wrap")
              ("s" sp-splice-sexp "Un-wrap")
              ("o" sp-change-inner "Override")
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

  (show-smartparens-global-mode t)
  :init
  (smartparens-global-mode t)

  (require 'smartparens-config)

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
  )
;; -----------------------------------------------------

;; show/hide blocks
(use-package hideshow
  :ensure t
  :hook ((c-mode-common . hs-minor-mode)
	 (emacs-lisp-mode . hs-minor-mode)
	 (java-mode . hs-minor-mode)
	 (lisp-mode . hs-minor-mode)
	 (perl-mode . hs-minor-mode)
	 (sh-mode . hs-minor-mode)
	 (js-mode . hs-minor-mode)
	 (json-mode . hs-minor-mode)
	 (ruby-mode . hs-minor-mode)))

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :init (setq markdown-command "multimarkdown")
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.markdown\\'" . markdown-mode)
         ("\\.md\\'" . markdown-mode)))

(use-package treemacs
  :disabled
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
  :bind (
         :map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-evil
  :after treemacs evil
  :ensure t)

(use-package treemacs-projectile
  :after treemacs projectile
  :ensure t)

(use-package powerline
  :ensure t)

(use-package smart-mode-line
  :ensure t
  :config
  (setq sml/no-confirm-load-theme t)
  (sml/setup))

(use-package smart-mode-line-powerline-theme
   :ensure t
   :after (powerline smart-mode-line)
   :config
   (sml/apply-theme 'powerline))

(use-package dockerfile-mode
   :ensure t
   :mode (("Dockerfile\\'" . dockerfile-mode)))

(use-package lexet-hydra-multiple-cursors
  ;; :load-path (lambda ()  (getenv "lexet_packages_dir"))
  ;; :after (multiple-cursors hydra)
  ;; :requires (multiple-cursors hydra)
  ;; :hook ((prog-mode . highlight-symbol-mode)
  ;;        (text-mode . highlight-symbol-mode))
  :config
  (lexet-hydra-multiple-cursors-init))

(use-package lexet-bindings
  :config
  (lexet-bindings-init))

(use-package lexet-project-indexation
  :config
  (lexet-project-indexation-init "alinement"))

(use-package lexet-indentation
  :config
  (lexet-indentation-init))

(use-package lexet-move-region
  :bind (("M-<up>" . move-line-region-up)
         ("M-<down>" . move-line-region-down)))

(use-package lexet-toggle-window-split
  :bind (("C-x |" . toggle-window-split)))

(use-package lexet-reverse-input-method
  :config
  (cfg:reverse-input-method 'russian-computer))

(use-package lexet-use-eslint-from-node-modules
  :hook ((flycheck-mode . lexet/use-eslint-from-node-modules)))

(use-package lexet-back-to-indentation-or-beginning
  :bind (("<home>" . back-to-indentation-or-beginning)))

(provide '.emacs)
;;; .emacs ends here
