Vim Haskell
===========

This repository stores the configuration files for making vim a little more
Haskell friendly.

Installation
------------

This repository simply glues together functionality that's found in different
other packages. Where possible, changes that are pushed upstream will be
removed from this repository.

The use of [pathogen](http://github.com/tpope/vim-pathogen/) is highly
recommended for installation. Once pathogen is installed, simply clone
this repository into your `.vim/bundle` directory.

There are a few other packages that are recommended, so a typical setup should
be something along the following lines:

    cd .vim/bundle/
    git clone git://github.com/zenzike/vim-haskell.git
    git clone git://github.com/msanders/snipmate.vim.git
    git clone git://github.com/scrooloose/syntastic.git
    cabal install hdevtools
    cabal install hlint
    cabal install hasktags

Overview
--------

### Syntax

The syntax file provided works with both Haskell and literate Haskell scripts.
Where literate Haskell files are concerned, the plugin tries to detect if
the file is a latex file, and, if so, makes use of this.

### Quickfix

If the current working directory contains a `cabal` file, then `makeprg` will be
set to `cabal build` and will put the ensuing warning and error messages into
the vim quickfix window. If no `cabal` file is detected, then the current file
is simply compiled with `ghc`

### Syntastic

Whenever you write to your file,
[syntastic](https://github.com/scrooloose/syntastic/) is run in order to check
your syntax. 
This works by using both [hdevtools](https://github.com/bitc/hdevtools) and 
[hlint](http://hackage.haskell.org/package/hlint/) to make suggestions to
improve your code.

I tend to use only `hdevtools`, but cranked up for all warnings, so this is in my `.vimrc`:

    let g:syntastic_haskell_checkers = ['hdevtools']
    let g:hdevtools_options = '-g -Wall'


### Unicode Entry

Some snippets are provided that allow unicode symbols to be entered relatively
easily in insert mode. For example, if your cursor is to the right of an ascii
`->` arrow, pressing `<TAB>` will result in a unicode `→` arrow. Likewise greek
letters can be entered by typing the name of the letter and pressing `<TAB>`.
For example, typing `psi<TAB>` will result in `ψ`.


TODO
----

Here's a list of features which are planned:

* Allow users to disable features like unicode entry.
* Use markdown syntax highlighting in lhs files that support it.
* Detect cabal files and enter an appropriate project mode.
* Part of this README should probably become a vimdoc file.

### Tags

There is a myriad of different tag generators for Haskell:

#### ghc

* GHC itself provides tags.

#### hasktags

* [hackage](http://hackage.haskell.org/package/hasktags)
* [github](https://github.com/chrisdone/hasktags)
* This used to be distributed with `ghc`.

#### fast-tags
* [hackage](http://hackage.haskell.org/package/fast-tags),
* [github](https://github.com/elaforge/fast-tags):
* Uses its own parser rather than `haskell-src` or `haskell-src-exts`.
* Handles `.hs` and `.hsc` but not `.lhs`.

#### lushtags

* [hackage](http://hackage.haskell.org/package/lushtags)
* [github](https://github.com/bitc/lushtags)
* Integrates with [tagbar](http://majutsushi.github.com/tagbar/).
* Fails when language pragmas unsupported

#### gasbag

* [homepage](http://kingfisher.nfshost.com/sw/gasbag/)
* Chooses outermost definitions.
* Only works with valid Haskell files.

#### hothasktags

* [hackage](http://hackage.haskell.org/package/hothasktags)
* [github](http://github.com/luqui/hothasktags)

Support for at least of one these would be nice.




