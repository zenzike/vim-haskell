" Vim filetype plugin
" Language: Literate Haskell
" Maintainer: Nicolas Wu <nicolas.wu@gmail.com>

if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

setlocal formatlistpat=^\\s*\\d\\+\\.\\s\\+\\\|^[-*+]\\s\\+

setlocal comments=s1fl:{-,mb:-,ex:-},:-- commentstring=--\ %s
if !filereadable(expand("%:p:h")."/Makefile")
    setlocal makeprg=lhs2TeX\ %\ >\ %<.tex\ &&\ xelatex\ %<.tex
    " setlocal makeprg=lhs2TeX\ %\ >\ %<.tex\ &&\ rubber\ -d\ %<.tex
endif

"" Snipmate completions
if !exists("g:haskell_tex")
  let g:haskell_tex = 1
endif
if !exists("g:haskell_unicode")
  let g:haskell_unicode = 1
endif
if g:haskell_tex
  set filetype+=.haskell-tex
endif
if g:haskell_unicode
  set filetype+=.haskell-unicode
endif

if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= "|setl cms< com< flp<"
else
  let b:undo_ftplugin = "setl cms< com< flp<"
endif

