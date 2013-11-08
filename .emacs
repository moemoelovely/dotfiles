;; from http://curiosity-drives.me/programming/rails/rails-emacs/
;; set load path
;; (setq load-path (cons “~/.emacs.d/” load-path))
;; (setq load-path (cons (expand-file-name "~/lisp/") load-path))

;; set language Japanese
(set-language-environment 'Japanese)
;; UTF-8
(prefer-coding-system 'utf-8)

;;Windowサイズと色を設定

;; set window status
(if window-system (progn
(setq initial-frame-alist '((width . 103)(height . 56)(top . 0)(left . 0)))
(set-background-color "Black")
(set-foreground-color "White")
(set-cursor-color "Gray")
))

;;Windowを透明にする

;; make window transparent
;; (set-frame-parameter nil 'alpha 80)

;;行番号と何文字目か情報を表示

;; show line and column number
(custom-set-variables '(line-number-mode t)
'(column-number-mode t))

;;タイトルバーにファイル名を表示

;; show filename in title bar
(setq frame-title-format (format "%%f - Emacs@%s" (system-name)))

;;自動的にバックアップファイルが作られるのをやめる(filename.txt~みたいなやつ)

;; Stop Auto Backup
(setq make-backup-files nil)
(setq auto-save-default nil)

;;改行時に自動でインデント

;; newline and indent
(global-set-key "\C-m" 'newline-and-indent)

;;その他もろもろ

;; Base settings
(setq read-file-name-completion-ignore-case t) ;; 補完で大文字小文字無視
(global-font-lock-mode t) ;;文字の色つけ
(setq display-time-24hr-format t) ;;24h表示
(display-time) ;;時計を表示
(auto-compression-mode t) ;;日本語infoの文字化け防止
(setq inhibit-startup-message t) ;;起動時のメッセージは消す
(setq-default tab-width 4 indent-tabs-mode nil);;tabは4文字分、改行後に自動インデント
(setq visible-bell t) ;; 警告音を消す
(show-paren-mode 1) ;; 対応する括弧を光らせる。
(if window-system  (global-hl-line-mode)) ;; 編集行のハイライト
(setq require-final-newline t) ;; ファイル末の改行がなければ追加
;(menu-bar-mode -1) ;;メニューバーを消す
(tool-bar-mode 0) ;;ツールバーを表示しない
(setq truncate-partial-width-windows nil) ;; ウインドウ分割時に画面外へ出る文章を折り返す

;;その他拡張
;;全角スペース、タブ、改行を可視化する

;
;====================================
;;jaspace.el を使った全角空白、タブ、改行表示モード
;;切り替えは M-x jaspace-mode-on or -off
;====================================
;;(require 'jaspace)
;; 全角空白を表示させる。
(setq jaspace-alternate-jaspace-string "□")
;; 改行記号を表示させる。
(setq jaspace-alternate-eol-string "↓\n")
;; タブ記号を表示。
;;(setq jaspace-highlight-tabs t) ; highlight tabs

;; EXPERIMENTAL: On Emacs 21.3.50.1 (as of June 2004) or 22.0.5.1, a tab
;; character may also be shown as the alternate character if
;; font-lock-mode is enabled.
;; タブ記号を表示。
(setq jaspace-highlight-tabs ?^ ) ; use ^ as a tab marker

;; from http://kagawacss.wiki.fc2.com/wiki/Emacs

;; bison-modeとflex-mode
;; bison
(autoload 'bison-mode "bison-mode" "bison" t)
(setq auto-mode-alist

    (append '(("\\.y$" . bison-mode))
             auto-mode-alist))
;; flex
(autoload 'flex-mode "flex-mode" "flex" t)
(setq auto-mode-alist

    (append '(("\\.l$" . flex-mode))
             auto-mode-alist))

;; クリップボード
(setq x-select-enable-clipboard t)
;; これを.emacsに追加しておくと他のソフト(Firefoxとか)でコピーした文字列をyankできるようになる。

;; インデント
;; C/C++のソースでタブ幅4にする。微妙におかしな設定かもしれないけど、意図した通りに動いてるのでよしとする。

; C
(add-hook 'c-mode-hook

       '(lambda()
           (c-set-style "linux")
           (setq c-basic-offset tab-width)
         ))

; C++
(add-hook 'c++-mode-hook

        '(lambda()
            (c-set-style "linux")
            (c-set-offset 'innamespace 0)
            (setq c-basic-offset tab-width)
            ))

; タブ幅
(setq-default tab-width 4)
; タブ幅の倍数
(setq tab-stop-list

    '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60))

;;backtab
(defun backtab()
  "Do reverse indentation"
  (interactive)
  (back-to-indentation)
  (delete-backward-char
   (if (< (current-column) (car tab-stop-list)) 0
     (- (current-column)
        (car (let ((value (list 0)))
               (dolist (element tab-stop-list value) 
                 (setq value (if (< element (current-column)) (cons element value) value)))))))))

(global-set-key [backtab] 'backtab)

(setq load-path (cons (expand-file-name "~/.emacs.d/") load-path))

;;auto
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/dict")
(ac-config-default)
(ac-set-trigger-key "TAB")
(setq ac-auto-start nil)

;; C-tab でウィンドウを変更
;; C-x C-tab でバッファ一覧
(if (window-system)
    (progn
      (define-key global-map [(C x) (C tab)] 'buffer-menu)
      (define-key global-map [C-tab] 'other-window)
      (define-key global-map [S-C-tab] (lambda () (interactive) (other-window -1))))
  ;; C-x C-x で移動
  ;; C-x C-o でバッファ一覧
  ;; C-\ でundo
  (progn
    (define-key global-map[(C x) (C x)] 'other-window)
    (define-key global-map [(C x) (o)] 'buffer-menu)
    (define-key global-map[(C \\)] 'advertised-undo))
)


;; 現在の関数名をモードラインに表示
(which-function-mode 1)

;;font
;; (add-to-list 'default-frame-alist '(font . "fontset-default"))
;; (set-frame-font "fontset-default")

;; (set-face-attribute 'default nil
;;                     :family "YukarryAA"
;;                     :height 130)

;; (set-fontset-font "fontset-default"
;;                   'japanese-jisx0208
;;                   '("YukarryAA*" . "jisx0208.*"))

;; (set-fontset-font "fontset-default"
;;                   'katakana-jisx0201
;;                   '("YukarryAA*" . "jisx0201.*"))

;;(add-to-list 'face-font-rescale-alist
;;             `(,(encode-coding-string ".*YukarryAA.*" 'emacs-mule) . 1.2))


(require 'matlab)
(autoload 'matlab-mode "matlab" "Enter MATLAB mode." t)
(autoload 'matlab-shell "matlab" "Interactive MATLAB mode." t)
(setq auto-mode-alist (cons '("\\.m\\'" . matlab-mode) auto-mode-alist))

;; auto-complete-modeの自動起動
(add-to-list 'ac-modes 'matlab-mode)

;; Anthy-el
;; (load-library "anthy")
;; (setq default-input-method "japanese-anthy")

;; Time-stamp
(if (not (memq 'time-stamp write-file-hooks))
    (setq write-file-hooks
          (cons 'time-stamp write-file-hooks)))

;; AUCTex
(setq TeX-parse-self nil)  ; ファイルを開いた時に自動パース
;; (setq TeX-auto-save  t)  ; パースしたデータを保存する

;;
;; Japanese TeX
;;

;; (require 'tex-site)
;; (require 'tex-jp)
(setq TeX-default-mode 'japanese-latex-mode)
(setq japanese-LaTeX-command-default "pLaTeX")
(setq japanese-LaTeX-default-style "jarticle")
;; (setq TeX-output-view-style '(("^dvi$" "." "xdvi '%d'")))
;; (setq preview-image-type 'dvipng)
;; (add-hook 'LaTeX-mode-hook (function (lambda ()
;;   (add-to-list 'TeX-command-list
;;     '("pTeX" "%(PDF)ptex %`%S%(PDFout)%(mode)%' %t"
;;      TeX-run-TeX nil (plain-tex-mode) :help "Run ASCII pTeX"))
;;   (add-to-list 'TeX-command-list
;;     '("pLaTeX" "%(PDF)platex %`%S%(PDFout)%(mode)%' %t"
;;      TeX-run-TeX nil (latex-mode) :help "Run ASCII pLaTeX"))
;;   (add-to-list 'TeX-command-list
;;     '("acroread" "acroread '%s.pdf' " TeX-run-command t nil))
;;   (add-to-list 'TeX-command-list
;;     '("pdf" "dvipdfmx -V 4 '%s' " TeX-run-command t nil))
;; )))
(setq TeX-command-default japanese-LaTeX-command-default)
(setq LaTeX-default-style japanese-LaTeX-default-style)
(setq LaTeX-command-BibTeX "jBibTeX")
