" Vim syntax file
" Language:          Literate Haskell
" URL:               http://github.com/zenzike/vim-haskell
" Version:           1.5
"
" This style guesses as to the type of markup used in a literate haskell file
" and will highlight (La)TeX markup if it finds any. This behaviour can be
" overridden, both glabally and locally using the lhs_markup variable or
" b:lhs_markup variable respectively.
"
" lhs_markup         must be set to either tex or none to indicate that
"                    you always want (La)TeX highlighting or no highlighting
"                    must not be set to let the highlighting be guessed
" b:lhs_markup       must be set to either tex or none to indicate that
"                    you want (La)TeX highlighting or no highlighting for
"                    this particular buffer
"                    must not be set to let the highlighting be guessed

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" First off, see if we can inherit a user preference for lhs_markup
if !exists("b:lhs_markup")
  if exists("lhs_markup")
    if lhs_markup =~ '\<\%(tex\|none\)\>'
      let b:lhs_markup = matchstr(lhs_markup,'\<\%(tex\|none\)\>')
    else
      echohl WarningMsg | echo "Unknown value of lhs_markup" | echohl None
      let b:lhs_markup = "unknown"
    endif
  else
    let b:lhs_markup = "unknown"
  endif
else
  if b:lhs_markup !~ '\<\%(tex\|none\)\>'
    let b:lhs_markup = "unknown"
  endif
endif

" Remember where the cursor is, and go to upperleft
let s:oldline=line(".")
let s:oldcolumn=col(".")
call cursor(1,1)

" If no user preference, scan buffer for our guess of the markup to
" highlight. We only differentiate between TeX and plain markup, where
" plain is not highlighted. The heuristic for finding TeX markup is if
" one of the following occurs anywhere in the file:
"   - \documentclass
"   - \begin{env}       (for env != code)
"   - \part, \chapter, \section, \subsection, \subsubsection, etc
if b:lhs_markup == "unknown"
  if search('\\documentclass\|\\begin{\%(code}\)\@!\|\\\%(sub\)*section\|\\chapter\|\\part\|\\paragraph','W') != 0
    let b:lhs_markup = "tex"
  else
    let b:lhs_markup = "plain"
  endif
endif

" If user wants us to highlight TeX syntax or guess thinks it's TeX, read it.
if b:lhs_markup == "tex"
  if version < 600
    source <sfile>:p:h/tex.vim
    set isk+=_
  else
    runtime! syntax/tex.vim
    unlet b:current_syntax
    " Tex.vim removes "_" from 'iskeyword', but we need it for Haskell.
    setlocal isk+=_
  endif
  syntax cluster lhsTeXContainer contains=@Spell,tex.* remove=hsComment
  syntax cluster lhsTeXNoVerb contains=@Spell,tex.* remove=texZone,texComment,hsComment
else
  syntax cluster lhsTeXContainer contains=@Spell remove=hsComment
  syntax cluster lhsTeXNoVerb contains=@Spell remove=hsComment
endif

" Literate Haskell is Haskell in between text, so at least read Haskell
" highlighting
if version < 600
  syntax include @haskellTop <sfile>:p:h/haskell.vim
else
  syntax include @haskellTop syntax/haskell.vim
endif

syntax spell toplevel

syntax region lhsHaskellBirdTrack start="^>" end="$" contains=@haskellTop,lhsBirdTrack,@NoSpell containedin=@lhsTeXContainer
syntax region lhsHaskellBirdTrack start="^<" end="$" contains=@haskellTop,lhsBirdTrack,@NoSpell containedin=@lhsTeXContainer
syntax region lhsHaskellBeginEndBlock start="^\\begin{code}\s*$" end="\%(^\\end{code}\)\@=" contains=@haskellTop,@beginCode,@NoSpell containedin=@lhsTeXContainer
syntax region lhsHaskellBeginEndBlock start="^\\begin{spec}\s*$" end="\%(^\\end{spec}\)\@=" contains=@haskellTop,@beginCode,@NoSpell containedin=@lhsTeXContainer

syntax region lhsHaskellInline keepend start="\%(\\verb\)\@<!|" end="|" contains=@haskellTop,@NoSpell containedin=@lhsTeXNoVerb

syntax match lhsBirdTrack "^>" contained
syntax match lhsBirdTrack "^<" contained

syntax match   beginCodeBegin "^\\begin" nextgroup=beginCodeCode contained
syntax region  beginCodeCode  matchgroup=texDelimiter start="\%(^\\begin\)\@<={" end="}"
syntax cluster beginCode      contains=beginCodeBegin,beginCodeCode,@NoSpell

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_tex_syntax_inits")
  if version < 508
    let did_tex_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink lhsBirdTrack Comment

  HiLink beginCodeBegin texCmdName
  HiLink beginCodeCode  texSection

  delcommand HiLink
endif

" Restore cursor to original position, as it may have been disturbed
" by the searches in our guessing code
call cursor (s:oldline, s:oldcolumn)

unlet s:oldline
unlet s:oldcolumn

let b:current_syntax = "lhaskell"
