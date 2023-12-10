(use-package meow
  :init (meow-global-mode 1)
  :demand nil
  :config
  (setq meow-cheatsheet-layout meow-cheatsheet-layout-colemak)
  (setq meow-expand-hint-remove-delay 3)
  (setq meow-use-clipboard t)
  (meow-motion-overwrite-define-key
   '("n" . meow-next)
   '("p" . meow-prev)
   '("<escape>" . ignore))
  (meow-leader-define-key
   '("?" . meow-cheatsheet)
   ;; To execute the originally e in MOTION state, use SPC e.
   '("1" . delete-other-windows)
   '("2" . split-window-below)
   '("3" . split-window-right)
   '("4" . "C-x 4")
   '("5" . "C-x 5")
   '("6" . eval-buffer)
   '("7" . display-buffer)
   '("8" . pop-to-buffer)
   '("9" . bury-buffer)
   '("0" . unbury-buffer)
   '("B" . ibuffer)
   '("C" . org-capture)
   '("G" . magit)
   '("o" . ace-window)
   '("p" . projectile-command-map)
   '("z" . popper-toggle-latest)
   '("[" . flycheck-previous-error)
   '("]" . flycheck-next-error)
   '("," . winner-undo)
   '("." . winner-redo)
   )
  (meow-normal-define-key
   '("0" . meow-expand-0)
   '("1" . meow-expand-1)
   '("2" . meow-expand-2)
   '("3" . meow-expand-3)
   '("4" . meow-expand-4)
   '("5" . meow-expand-5)
   '("6" . meow-expand-6)
   '("7" . meow-expand-7)
   '("8" . meow-expand-8)
   '("9" . meow-expand-9)
   '("-" . negative-argument)
   '(";" . meow-reverse)
   '("," . meow-inner-of-thing)
   '("." . meow-bounds-of-thing)
   '("[" . meow-beginning-of-thing)
   '("]" . meow-end-of-thing)
   '("/" . meow-visit)
   '("a" . meow-append)
   '("A" . meow-open-below)
   '("b" . meow-back-word)
   '("B" . meow-back-symbol)
   '("c" . meow-change)
   '("C" . meow-change-char)
   '("d" . meow-kill)
   '("D" . meow-backward-delete)
   '("e" . meow-left)
   '("E" . meow-left-expand)
   '("f" . meow-find)
   '("g" . meow-cancel-selection)
   '("G" . meow-grab)
   '("h" . negative-argument)
   '("i" . meow-right)
   '("I" . meow-right-expand)
   '("j" . meow-join)
   '("k" . meow-insert)
   '("K" . meow-open-above)
   '("l" . meow-line)
   '("L" . consult-goto-line)
   '("m" . meow-mark-word)
   '("M" . meow-mark-symbol)
   '("n" . meow-next)
   '("N" . meow-next-expand)
   '("o" . meow-block)
   '("O" . meow-to-block)
   '("p" . meow-prev)
   '("P" . meow-prev-expand)
   '("q" . meow-quit)
   '("r" . meow-replace)
   '("R" . meow-swap-grab)
   '("S" . save-buffer)
   '("t" . meow-till)
   '("T" . dirvish-side)
   '("u" . undo-only)
   '("U" . undo-redo)
   '("v" . meow-search)
   '("w" . meow-next-word)
   '("W" . meow-next-symbol)
   '("x" . meow-delete)
   '("y" . meow-save)
   '("Y" . meow-yank)
   '("z" . meow-pop-selection)
   '("'" . repeat)
   '("<escape>" . ignore))
  )
(provide 'init-meow)
