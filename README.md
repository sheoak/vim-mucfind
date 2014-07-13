vim-mucfind
===========

Vim plugin to perform search with mu and insert the selected result

This plugin has been created to be used with this great unix-style
mail setup by Tomka <tomka@g.o>:
http://dev.gentoo.org/~tomka/mail.html

Of course you can use it for any search using “mu”.
Please note I’m a vim-script beginner so this script can most likely be improve.
Any feedback is welcome.

## Installation

Recommanded: use [Vundle](https://github.com/gmarik/vundle) for the installation.

sed, grep and mu binaries must be in the path.


### Vundle

Add this to your ~/.vimrc:

    Plugin 'sheoak/vim-mucfind.vim'

Then run:

    :PluginInstall in vim


### Manual

Copy plugin/mucfind.vim to ~/.vim/plugin directory and restart vim.


## Configuration

You can remap the default key (F6) like this in your ~/.vimrc

    " replace F8 by any Fn key or a valid combinaison for insert mode
    let g:mucfind_run_key = '<F8>'


