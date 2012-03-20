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
this repository into your `.vim/bundle` directory. There are a few
other packages that are recommended, so a typical setup should be something
along the following lines:

    cd .vim/bundle/
    git clone git://github.com/zenzike/vim-haskell.git
    git clone git://github.com/msanders/snipmate.vim.git
    git clone git://github.com/scrooloose/syntastic.git


