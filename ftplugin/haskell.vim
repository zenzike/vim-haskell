if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1
let s:cpo_save = &cpo
set cpo&vim
let b:undo_ftplugin = "setl mp< efm< isk< com< cms<"

" This will set the variables that QuickFix needs
" in order to compile, if you are on a project that 
" has a cabal file, use "cabal build", otherwise
" use "ghc --make" on the current file
let s:cabalFilePresent = filereadable(glob('*.cabal'))
if s:cabalFilePresent
  setl makeprg=cabal\ build
else
  let s:currentFile = expand('%')
  if !exists('b:qfOutputdir')
    let b:qfOutputdir = tempname()
    call mkdir(b:qfOutputdir)
  endif
  let &l:makeprg = 'ghc --make % -outputdir ' . b:qfOutputdir
endif

setl errorformat=
  \%-Z\ %#,
  \%W%f:%l:%c:\ Warning:\ %m,
  \%E%f:%l:%c:\ %m,
  \%E%>%f:%l:%c:,
  \%+C\ \ %#%m,
  \%W%>%f:%l:%c:,
  \%+C\ \ %#%tarning:\ %m,

setl iskeyword=a-z,A-Z,_,.,39,48-57

setl comments=s1fl:{-,mb:-,ex:-},:-- 
setl commentstring=--\ %s

let &cpo = s:cpo_save
unlet s:cpo_save
