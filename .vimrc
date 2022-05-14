set nocompatible              " be iMproved, required
filetype off                  " required

" Vundle -{{{

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'	 " autocomplete for programming languages
Plugin 'instant-markdown/vim-instant-markdown'	" view markdown in browser

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" end of Vundle ---}}}

set foldmethod=indent
" Kite autocomplete for python ---{{{
" enable kite for all supported languages:
"let g:kite_supported_languages = ['*']
" disable kite for all supported languages:
"let g:kite_supported_languages = []
"enable kite for python files:
let g:kite_supported_languages = ['python']
let g:kite_tab_complete=1
set completeopt+=menuone
set completeopt+=noinsert
set completeopt-=preview
"}}}


" vim -basic settings ---{{{

" syntax
syntax on

" numbered lines
set number 

" colorscheme
colorscheme hackerman

" Map leaders
let mapleader="-"
let maplocalleader="\\"

set incsearch	" highlight the search while typing
"}}}


" status line ---{{{
set laststatus=2		" always use a status line
set statusline=%.20F		" path to file
"}}}

" Mappings ---{{{
" Mapping - Normal Mode ---{{{
nnoremap <space> viw|			" select word
nnoremap <leader>u viwU|		" convert word to uppercase
nnoremap <leader>l viwu|		" convert word to lowercase
nnoremap <leader>ev :leftabove vsplit $MYVIMRC<cr>|	" open vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>|	" use vimrc as source file
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel|	" wrap word with apostrephes
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel|	" wrap word with apostrephes
nnoremap <leader>( viw<esc>a)<esc>bi(<esc>lel|	" wrap word with round parenthesis 
nnoremap <leader>[ viw<esc>a]<esc>bi[<esc>lel|	" wrap word with square parenthesis
nnoremap <leader>{ viw<esc>a}<esc>bi{<esc>lel|	" wrap word with curly parenthesis
nnoremap H <home>|		" go to the beginning of line
nnoremap L <end>|		" go to the end of line
nnoremap <leader>pb :execute "leftabove vsplit " . bufname("#")<cr>|	" open the previous buffer
nnoremap / /\v|		" all searches are verymagic
nnoremap <leader>sh :nohlsearch<cr>|	" stop highlight from last search
"nnoremap <leader>g :silent execute "grep! -R " . shellescape(expand("<cWORD>")) . " ."<cr>:copen 8<cr>|	" grep word under the cursor and open quickfix window
nnoremap <leader>nn :cnext<cr>|	" next result from grep
nnoremap <leader>pp :cprevious<cr>|	" previous result from grep
"nnoremap <leader>cc :cclose<cr>|	" close error window
"}}}

" Mapping - Insert Mode -{{{
inoremap <c-d> <esc>ddi|		" delete line
inoremap <leader>u <esc>viwUi|		" convert word to uppercase 
inoremap <leader>l <esc>viwui|		" convert word to lowercase
inoremap jk <esc>|			" jk will exit input mode
inoremap JK <esc>|			" JK will exit input mode
"}}}

" Mapping - Visual Mode ---{{{
vnoremap <leader>" <esc>`>a"<esc>`<i"<esc>|	" wrap selected text with apostrephes
vnoremap <leader>' <esc>`>a'<esc>`<i'<esc>|	" wrap selected text with apostrephes
vnoremap <leader>( <esc>`>a)<esc>`<i(<esc>|	" wrap selected text with parenthesis
vnoremap <leader>[ <esc>`>a]<esc>`<i[<esc>|	" wrap selected text with square parenthesis
vnoremap <leader>{ <esc>`>a}<esc>`<i{<esc>|	" wrap selected text with curly parenthesis
vnoremap <leader>r y<esc>:s/\v<c-r>"//g<left><left>|	" replace highlighted text
vnoremap <leader>R y<esc>:%s/\v<c-r>"//g<left><left>|	" replace all instances of highlighted text
vnoremap / y<esc>:/\v<c-r>"|	" search for highlighted string
"}}}
"}}}

" Operator-Pending Mappings ---{{{
onoremap in( :<c-u>normal! f(vi(<cr>|	" select the text inside the next round parenthesis
onoremap il( :<c-u>normal! F)vi)<cr>|	" select the text inside the last round parenthesis
onoremap in[ :<c-u>normal! f[vi[<cr>|	" select the text inside the next square parenthesis
onoremap il[ :<c-u>normal! F]vi]<cr>|	" select the text inside the last square parenthesis
onoremap in{ :<c-u>normal! f{vi{<cr>|	" select the text inside the next curly parenthesis
onoremap il{ :<c-u>normal! F}vi}<cr>|	" select the text inside the last curly parenthesis
"}}}

" Abbreviations ---{{{
" load variables:
source $HOME/.dotfiles/vim/cred.vim
" Input mode:
iabbrev ccopy (c) <esc>:r! date "+\%Y"<cr>i<bs><esc>ea <SPACE><ESC>:normal! i<C-R><C-R>=MY_NAME<CR><ESC>|	" copyright
iabbrev gitprof <ESC>:normal! i<C-R><C-R>=GITHUB_PROFILE<CR><ESC>|	" github profile
iabbrev workmail <ESC>:normal! i<C-R><C-R>=MY_EMAIL<CR><ESC>|	" work email
"}}}

" Filetype specific settings ---{{{
" for python programs ---{{{
augroup filetype_py
	autocmd!
	autocmd FileType python setlocal foldmethod=indent|	" set fold method to indent in python files
	autocmd FileType python setlocal foldlevel=99|		" all the folds are open when opening a python file 
	autocmd FileType python nnoremap <buffer> <localleader>c I# <esc>|	" add comment to python file line in normal mode
	autocmd FileType python iabbrev shebang #!/usr/bin/env python3|" shebang line
augroup END
"}}}

" for c programs ---{{{
augroup filetype_c
	autocmd!
	autocmd FileType c setlocal foldmethod=syntax|	" set fold method to indent in c files
	autocmd FileType c setlocal foldlevel=99|	" all the folds are open when opening a c file 
	" abbreviations
	autocmd FileType c iabbrev<buffer> iff if()<cr>{<cr>}<up><up><right><right><c-r>=Eatchar('\s')<cr>|	" if statement
	autocmd FileType c iabbrev <buffer> switchh switch()<cr>{<cr>default:<cr>break;<cr>}<up><up><up><up><right><right><right><right><right><right><c-r>=Eatchar('\s')<cr>|	" switch statement
	autocmd FileType c iabbrev <buffer> forr for(;;)<cr>{<cr>}<up><up><right><right><right><c-r>=Eatchar('\s')<cr>|	" for loop
	autocmd FileType c iabbrev <buffer> whilee while()<cr>{<cr>}<up><up><right><right><right><right><right><c-r>=Eatchar('\s')<cr>|	" while loop
	autocmd FileType c iabbrev <buffer> template #include <stdio.h><cr>#include <stdlib.h><cr><cr><cr>int main(int argc, char *argv[])<cr>{<cr>return 0;<cr>}<esc><up>O<c-r>=Eatchar('\s')<cr>|	" c template
	autocmd FileType c iabbrev <buffer> ifarg if(argc < 2)<cr>{<cr>printf("Usage:\n");<cr>}<c-r>=Eatchar('\s')<cr>|	" condition from command line arguments
	autocmd FileType c iabbrev <buffer> #i #include <><left><c-r>=Eatchar('\s')<cr>|	" include
	autocmd FileType c iabbrev <buffer> doo do<cr>{<cr>}<cr>while();<left><left><c-r>=Eatchar('\s')<cr>|	" do-while loop
	" mapping
	autocmd FileType c noremap <buffer> <localleader>c I// <esc>|	" add comment to c file line in normal mode
	autocmd FileType c vnoremap <buffer> <localleader>c <esc>`>a*/<esc>`<i/*<esc>|	" comment the highlighted text
	autocmd FileType c nnoremap <buffer> <leader>w :match Error /\v\s+$/<cr>|	" highlight trailing spaces
augroup END
"}}}

" for bash programs ---{{{
augroup filetype_sh
	autocmd!
	autocmd FileType sh setlocal foldmethod=indent|	" set fold method to indent on bash script files
	autocmd FileType sh setlocal foldlevel=99|	" all the folds are open when opening a bash script file 
	autocmd FileType sh nnoremap <buffer> <localleader>c I# <esc>|	" add comment to bash script file line in normal mode
	" abbreviations
	autocmd FileType sh iabbrev <buffer> shebang #!/bin/bash|	" shebang line
augroup END
	
"}}}

" vim files - folding {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker|	" set fold method to marker on vim files
    autocmd FileType vim setlocal foldlevelstart=0|	" fold automatically when opening a vim file
augroup END
"}}}
"}}}

" functions ---{{{
" consume the last character
func Eatchar(pat)
	let c = nr2char(getchar(0))
  	return (c =~ a:pat) ? '' : c
endfunc
" Example: iabbr <silent> if if ()<Left><C-R>=Eatchar('\s')<CR>
"}}}


" When started as "evim", evim.vim will already have done these settings, bail
" out.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
augroup END

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif
