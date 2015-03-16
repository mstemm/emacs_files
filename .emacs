;; this is unnecessary unless you want zcat
;;(load-library "~/elisp/cc-mode.el")
(load-library "~/elisp/color-theme-zenburn.el")
;;(require 'color-theme-zenburn)
;;(color-theme-zenburn)
(load-library "~/elisp/ssh.el")
(load-library "~/elisp/lcvs.el")
(load-library "~/elisp/php-mode.el")
(load-library "~/elisp/psvn.el")
(setq split-width-threshold nil)
;(require 'psvn)
(setq svn-status-verbose nil)
;(setq svn-status-default-diff-arguments '("--diff-cmd" "/home/mstemm/bin/bdiff" "-x" "-b" "-B"))
(setq svn-status-default-diff-arguments nil)
;(load-library "~/elisp/vc.el")
(load-library "~/elisp/mwheel.el")
;;(load-library "~/elisp/ruby-mode.el")
(global-font-lock-mode 1)
(global-set-key "\M-?" 'help-command)	;beyond any doubt, binding this to ^H was the stupidest thing RMS did to EMACS
(global-set-key "\M-?\M-?" 'help-for-help) ;let's be as consistent as possible
(global-set-key "\C-xn" 'other-window)
(global-set-key "\C-xp" '(lambda () (interactive) (other-window -1)))
(global-set-key "\C-xd" 'delete-window)
(global-set-key "\C-x\C-g" 'gdb)
(global-set-key "\C-x\C-v" 'find-file-other-window)
(global-set-key "\C-x\C-l" 'goto-line)
(global-set-key "\C-x\C-m" 'compile)
(global-set-key "\C-x\C-n" 'next-error)
(global-set-key "\C-h" 'delete-backward-char)
(global-set-key "\M-h" 'backward-kill-word)
(global-set-key "\e\C-h" 'backward-kill-word)
(global-set-key "\e\C-?" 'backward-kill-word) ;DEL doesn't seem to work
(global-set-key "\M-=" 'what-line)
(global-set-key "\C-x\C-z" 'shrink-window) 
(global-set-key "\C-xz" 'grow-window)
(global-set-key "\C-z" 'suspend-emacs)
(global-set-key "\C-q" 'indent-region)
(global-set-key "\C-t" 'call-last-kbd-macro)

(global-set-key "\C-m" 'newline-and-indent)

(defun count-words-region (start end)
  (interactive "r")
  (save-excursion
    (let ((n 0))
      (goto-char start)
      (while (< (point) end)
	(if (forward-word 1)
	    (setq n (1+ n))))
      (message "Region has %d words" n)
      n)))

(setq inferior-lisp-program "/usr/sww/bin/cl") ;make common lisp the lisp

(setq c-tab-always-indent nil)
(setq gnus-show-threads t)

;;(autoload 'ruby-mode "ruby-mode" "Load ruby-mode")
;;(add-to-list 'auto-mode-alist '("\\.rb\\'" . ruby-mode))
;;(setq auto-mode-alist  (cons '(".rhtml$" . html-mode) auto-mode-alist))
(setq ruby-indent-level 4)
;; uncomment the next line if you want syntax highlighting
;;(add-hook 'ruby-mode-hook 'turn-on-font-lock)

;; turn on line number mode
(line-number-mode 1)

;;mail stuff
(setq gnus-default-nntp-server "agate.berkeley.edu")

(setq auto-mode-alist
      (nconc (list '("\\.[ly]$" . c-mode) ;for lex/yacc input
                   '("\\.pl$" . perl-mode)
		   '("\\.pm$" . perl-mode)
                   '("\\.tgz" . tar-mode)
		   '("\\.java$" . java-mode)
		   '("\\.cc$" . c++-mode)
		   '("\\.h$" . c++-mode)
		   '("\\.c$" . c++-mode)
		   '("\\.xsd$" . xml-mode)		   
                   '("\\.html$". html-helper-mode)
                   )
             auto-mode-alist))

;;limit the size of shell buffers
(setq comint-buffer-maximum-size 10000)
(add-hook 'comint-output-filter-functions
	  'comint-truncate-buffer)

(autoload 'c++-mode "cc-mode" "C++ Editing Mode" nil)
(autoload 'c-mode "cc-mode" "C Editing Mode" nil)
(autoload 'c-edit-macro "c-edit-macro" "C Macro Editing" t)

(setq auto-mode-alist (append (list '("\\.cc\$" . c++-mode)
				    '("\\.hh\$" . c++-mode)
				    '("\\.C\$" . c++-mode)
				    '("\\.H\$" . c++-mode)
				    '("\\.c\$" . c-mode)
				    '("\\.h\$" . c-mode))
			      auto-mode-alist))

(defun my-c-mode-hook ()
  (c-set-style "BSD")

  (setq c-basic-offset 4)

  (define-key c-mode-map "\C-c\C-c" 'compile)
  (define-key c++-mode-map "\C-c\C-c" 'compile)
  (define-key c-mode-map "\C-cg" 'gdb)
  (define-key c++-mode-map "\C-cg" 'gdb)
  (define-key c-mode-map "\r" 'newline-and-indent)
  (define-key c++-mode-map "\r" 'newline-and-indent))

(add-hook 'c-mode-hook 'my-c-mode-hook)
(add-hook 'c++-mode-hook 'my-c-mode-hook)

(setq lcvs-log-restrict-to-branch nil)

(setq buffers-menu-sort-function
      'sort-buffers-menu-by-size)

(autoload 'compile-internal "compile")
(defun grope (sym)
  (interactive (list (read-string "Grope for: " (current-word))))
  (compile-internal (concat "grope " sym) "No more grope hits" "grope"
                    nil grep-regexp-alist))
(custom-set-variables)
					;(custom-set-faces
					; '(font-lock-comment-face ((((class color) (background dark)) (:foreground "Orange"))))
					; '(font-lock-warning-face ((((class color) (background dark)) (:foreground "Pink")))))

(setq tab-width 4)
(setq indent-tabs-mode nil) 

(defun any-mode-untabify ()
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward "[ \t]+$" nil t)
      (delete-region (match-beginning 0) (match-end 0)))
    (goto-char (point-min))
    (if (search-forward "\t" nil t)
	(untabify (1- (point)) (point-max))))
  nil)

(add-hook 'text-mode-hook
	  '(lambda ()
	     (make-local-variable 'write-contents-hooks)
	     (add-hook 'write-contents-hooks 'any-mode-untabify)))

(add-hook 'xml-mode-hook
	  '(lambda ()
	     (make-local-variable 'write-contents-hooks)
	     (add-hook 'write-contents-hooks 'any-mode-untabify)))

(add-hook 'perl-mode-hook
	  '(lambda ()
	     (make-local-variable 'write-contents-hooks)
	     (add-hook 'write-contents-hooks 'any-mode-untabify)))

(add-hook 'c-mode-hook
	  '(lambda ()
	     (make-local-variable 'write-contents-hooks)
	     (add-hook 'write-contents-hooks 'any-mode-untabify)))

(add-hook 'java-mode-hook
	  '(lambda ()
	     (make-local-variable 'write-contents-hooks)
	     (add-hook 'write-contents-hooks 'any-mode-untabify)))

(add-hook 'c++-mode-hook
	  '(lambda ()
	     (make-local-variable 'write-contents-hooks)
	     (add-hook 'write-contents-hooks 'any-mode-untabify)))

(add-hook 'latex-mode-hook
	  '(lambda ()
	     (make-local-variable 'write-contents-hooks)
	     (add-hook 'write-contents-hooks 'any-mode-untabify)))

(add-hook 'sgml-mode-hook
	  '(lambda ()
	     (make-local-variable 'write-contents-hooks)
	     (add-hook 'write-contents-hooks 'any-mode-untabify)))

(add-hook 'ruby-mode-hook
	  '(lambda ()
	     (make-local-variable 'write-contents-hooks)
	     (add-hook 'write-contents-hooks 'any-mode-untabify)))

(add-hook 'lua-mode-hook
	  '(lambda ()
	     (make-local-variable 'write-contents-hooks)
	     (add-hook 'write-contents-hooks 'any-mode-untabify)))

(add-hook 'sql-mode-hook
	  '(lambda ()
	     (make-local-variable 'write-contents-hooks)
	     (add-hook 'write-contents-hooks 'any-mode-untabify)))
