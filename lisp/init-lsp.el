
(use-package lsp-mode
  :defer t
  :custom
  (lsp-completion-provider :none)
  :bind
  ("C-c l n" . lsp-rename)
  ("C-c l s"	. lsp-ui-peek-find-workspace-symbol)
  ("C-c l d"	. lsp-find-definition)
  ("C-c l i"	. lsp-find-implementation)
  ("C-c l r"	. lsp-find-references)
  ("C-c l h"    . lsp-describe-thing-at-point)
  ("C-c l f"	. lsp-format-buffer)
  ("C-c l F"	. lsp-organize-imports)
  ("C-c l a"	. lsp-execute-code-action)
  ("C-c l m"	. lsp-ui-imenu)
  ("C-c l M"	. lsp-ui-imenu--kill)
  ("C-c l S"	. lsp-ui-sideline-mode)
  ("C-c l t"	. lsp-find-type-definition)
  ("C-c l D"	. lsp-ui-peek-find-definitions)
  ("C-c l I"	. lsp-ui-peek-find-implementation)
  ("C-c l R"	. lsp-ui-peek-find-references)

  :init
  (setq lsp-keymap-prefix "C-c e")
  (defun lan/lsp-mode-setup-completion ()
    (setf (alist-get 'styles (alist-get 'lsp-capf completion-category-defaults))
          '(orderless))) ;; Configure orderless
  (setq lsp-signature-auto-activate nil
        lsp-headerline-breadcrumb-enable nil
        lsp-eldoc-render-all nil
        lsp-signature-render-documentation nil
        
        ;; Go
        lsp-gopls-hover-kind "NoDocumentation"
        lsp-gopls-use-placeholders t

        lsp-semantic-tokens-enable t
        lsp-progress-spinner-type 'progress-bar-filled
        lsp-enable-folding nil
        lsp-enable-symbol-highlighting nil
        lsp-enable-text-document-color nil
        lsp-enable-on-type-formatting nil)
  :hook (
         (prog-mode . (lambda ()
                        (unless (derived-mode-p 'emacs-lisp-mode 'lisp-mode 'sh-mode 'makefile-mode)
                          (lsp-deferred))))
         (lsp-completion-mode . lan/lsp-mode-setup-completion)
         (lsp-mode . lsp-enable-which-key-integration))
  :config
  
  (use-package lsp-ui
    :bind(("C-c u" . lsp-ui-imenu)
          :map lsp-ui-mode-map
          ("s-<return>" . lsp-ui-sideline-apply-code-actions))
    :hook (lsp-mode . lsp-ui-mode)
    :init
    (setq lsp-ui-sideline-show-diagnostics nil
          lsp-ui-sideline-ignore-duplicate t
          lsp-ui-doc-delay 0.1
          lsp-ui-doc-show-with-cursor (not (display-graphic-p))
          lsp-ui-imenu-auto-refresh 'after-save
          lsp-ui-imenu-colors `(,(face-foreground 'font-lock-keyword-face)
                                ,(face-foreground 'font-lock-string-face)
                                ,(face-foreground 'font-lock-constant-face)
                                ,(face-foreground 'font-lock-variable-name-face))))

  (use-package lsp-tailwindcss
    :init
    (setq lsp-tailwindcss-add-on-mode t))

  ;; Enable LSP in org babel without checking centaur-lsp
  (cl-defmacro lsp-org-babel-enable (lang)
    "Support LANG in org source code block."
    (cl-check-type lang string)
    (let* ((edit-pre (intern (format "org-babel-edit-prep:%s" lang)))
           (intern-pre (intern (format "lsp--%s" (symbol-name edit-pre)))))
      `(progn
         (defun ,intern-pre (info)
           (setq buffer-file-name (or (->> info caddr (alist-get :file))
                                      "org-src-babel.tmp"))
           ;; Directly use lsp-mode
           (when (fboundp 'lsp-deferred)
             ;; Avoid headerline conflicts
             (setq-local lsp-headerline-breadcrumb-enable nil)
             (lsp-deferred)))
         (put ',intern-pre 'function-documentation
              (format "Enable `lsp-mode' in the buffer of org source block (%s)."
                      (upcase ,lang)))

         (if (fboundp ',edit-pre)
             (advice-add ',edit-pre :after ',intern-pre)
           (progn
             (defun ,edit-pre (info)
               (,intern-pre info))
             (put ',edit-pre 'function-documentation
                  (format "Prepare local buffer environment for org source block (%s)."
                          (upcase ,lang))))))))

  (defconst org-babel-lang-list
    '("go" "python" "ipython" "ruby" "js" "css" "sass" "c" "rust" "java" "cpp" "c++"))
  (add-to-list 'org-babel-lang-list "shell")
  (dolist (lang org-babel-lang-list)
    (eval `(lsp-org-babel-enable ,lang)))

  (use-package dap-mode
    :disabled
    :bind
    (:map dap-mode-map
          (("<f12>" . dap-debug)
           ("<f8>" . dap-continue)
           ("<f6>" . dap-next)
           ("<f7>" . dap-breakpoint-toggle)))
    :config
    ;; Enabling only some features
    (setq dap-auto-configure-features '(sessions locals controls tooltip))
    (require 'dap-node)
    (dap-node-setup) ;; Automatically installs Node debug adapter if needed
    (require 'dap-chrome)
    (dap-chrome-setup))
  )

(provide 'init-lsp)
;;; init-lsp.el ends here
