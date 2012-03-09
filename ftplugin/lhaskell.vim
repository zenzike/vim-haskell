
" Vim filetype plugin
" Language: Literate Haskell
" Maintainer: Nicolas Wu <nicolas.wu@gmail.com>
" Latest Revision: 2012-02-21

if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

setlocal formatlistpat=^\\s*\\d\\+\\.\\s\\+\\\|^[-*+]\\s\\+

setlocal comments=s1fl:{-,mb:-,ex:-},:-- commentstring=--\ %s
setlocal formatoptions-=t formatoptions+=croql
setlocal makeprg=lhs2TeX\ %\ >\ %<.tex\ &&\ rubber\ -d\ %<.tex

if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= "|setl cms< com< fo< flp<"
else
  let b:undo_ftplugin = "setl cms< com< fo< flp<"
endif

