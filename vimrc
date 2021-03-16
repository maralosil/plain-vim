" Simple .vimrc file 
" @author Marcelo Silva 
" @version 1.0 
" @date 16.03.2021

" Show line numbers
set number

" Show file stats
set ruler

" Encoding
set encoding=utf-8

" Whitespace
set wrap
set textwidth=80
set tabstop=8
set softtabstop=8
set shiftwidth=8
set expandtab

" Last line
set showmode
set showcmd

" Color scheme (terminal)
set t_Co=256
colorscheme paramount

" Sintax enable
syntax enable

" Searching
set showmatch
set incsearch
set hlsearch

" Set symbols for tabstops and EOLs
" set list listchars=tab:▸\ ,eol:¬
" set list listchars=tab:»\ ,eol:¶
set list listchars=tab:▸\ ,eol:¶

" Cscope
" use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
set cscopetag

" check cscope for definition of a symbol before checking ctags: set to 1
" if you want the reverse search order.
set csto=0

" add any cscope database in current directory
if filereadable("cscope.out")
    cs add cscope.out  
" else add the database pointed to by environment variable
elseif $CSCOPE_DB != ""
    cs add $CSCOPE_DB
endif

" show msg when any other cscope db added
set cscopeverbose  

" Cscope shortcuts
" Find this C symbol
nmap zs :cs find s <cword><CR>
" Find this definition
nmap zg :cs find g <cword><CR>
" Find functions calling this function
nmap zc :cs find c <cword><CR>
" Find places where this symbol is assigned a value
nmap za :cs find a <cword><CR>
" Find this text
nmap zt :cs find t <cword><CR>
" Find this egrep pattern
nmap ze :cs find e <cword><CR>
" Find this file
nmap zf :cs find f <cword><CR>
" Find files including this file
nmap zi :cs find i <cword><CR>

" Custom functions
function! Cpptab()
    set tabstop=4
    set shiftwidth=4
    set softtabstop=4
    set expandtab
endfunction

function! Ctab()
    set tabstop=8
    set shiftwidth=8
    set softtabstop=8
    set noexpandtab
endfunction

" Custom commands
:command! Cpptab call Cpptab()
:command! Ctab call Ctab()
