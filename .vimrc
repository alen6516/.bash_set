source ~/.vim_plug
source ~/.cscope_maps.vim

set bg=dark
set nu
set ruler           " turn on the display of coordination at right-bottom cornor
set incsearch       " jump to the searching pattern while still typing
set ic              " ignore the case of searching pattern
set ai              " auto indent
set scrolloff=3     " preserve several lines when scrolling
set tabstop=4       " the definition for a tab of vim
set shiftwidth=4    " the width of auto indent
set expandtab       " expand a tab as several spaces, for original tab, use :retab, or :%s/^I/    /gc
"set mouse=a        " allow using mouse to move the cursor
set encoding=utf-8
set splitright		" set split window to right-hand side

set foldenable      " enable fold mode
set foldmethod=manual   " zz to create; zo to open; zc to close

" allow using :w!! to write a edited read-only file (press quickly)
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" #### line number color #### 
set cursorline
"hi LineNr cterm=NONE ctermfg=DarkGrey ctermbg=NONE
hi CursorLineNR term=bold cterm=bold ctermfg=yellow

"#### set shortcut #######
"nmap <leader>l :set nonumber!<CR>:set foldcolumn=0<CR>
nmap <C-d> 10j
nmap <C-u> 10k
nmap <leader>h :noh<CR>
"nmap <C-S-g> gg=G

" quick quit
nmap qqq :q<cr>

" window switching
"nmap <leader>w<Right> <C-w><Right>
"nmap <leader>w<Left>  <C-w><Left>
"nmap <leader>w<Up>    <C-w><Up>
"nmap <leader>w<Down>  <C-w><Down>
"nmap <leader>ww       <C-w>w

" tab #######
nmap te :tabe
nmap tc :tabc
nmap tn :tabn
nmap tp :tabp
nmap t<Right> gt
nmap t<Left> gT

"###########################################
" enable copy between different vim instance

"map <C-y> <Nop>
map <leader>y :w! /tmp/vitmp<CR>

"map <C-p> <Nop>
map <leader>p :r! cat /tmp/vitmp<CR>

vmap <leader>y :w! /tmp/vitmp<CR>
nmap <leader>p :r! cat /tmp/vitmp<CR>
"###########################################

"###########################################
" move cursor to the end of text after p,
" and without moving cursor after gp
noremap p gp
noremap P gP
noremap gp p
noremap gP P
"###########################################


"######################################
" highlight cursor word but don't jump
nnoremap <silent> # :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>
"######################################

"#####################
"# indent & unindent #
nmap <tab> V>
nmap <s-tab> V<
vmap <tab> >gv
vmap <s-tab> <gv
imap <s-tab> <Esc>V<i

"###############
"#### color ####
if !has('gui_running')
	set t_Co=256
endif
"colorscheme torte # set color style (select from /usr/share/vim/vimNN/colors/ , vimNN is the version number of your vim)


set hlsearch        " highlight the searching result
hi Search guibg=Yellow guifg=Black ctermbg=Yellow ctermfg=Black

"##### set the style of status line ####
set laststatus=2    " turn on the status line of vim, set 1 to turn 0ff
"set statusline=%#filepath#[%{expand('%:p')}]%#filetype#[%{strlen(&fenc)?&fenc:&enc},\ %{&ff},\ %{strlen(&filetype)?&filetype:'plain'}]%#filesize#%{FileSize()}%{IsBinary()}%=%#position#%c,%l/%L\ [%3p%%]

hi filepath cterm=none ctermbg=238 ctermfg=40
hi filetype cterm=none ctermbg=238 ctermfg=45
hi filesize cterm=none ctermbg=238 ctermfg=225
hi position cterm=none ctermbg=238 ctermfg=228

function IsBinary()
    if (&binary == 0)
        return ""
    else
        return "[Binary]"
    endif
endfunction

function FileSize()
    let bytes = getfsize(expand("%:p"))
    if bytes <= 0
        return "[Empty]"
    endif
    if bytes < 1024
        return "[" . bytes . "B]"
    elseif bytes < 1048576
        return "[" . (bytes / 1024) . "KB]"
    else
        return "[" . (bytes / 1048576) . "MB]"
    endif
endfunction
"#### end the style of status line ####

"#### end of color ####
"######################


"###########################
"#### custom file title ####
"autocmd BufNewFile *.py exec ":call SetTitle_py()"
"autocmd BufNewFile *.sh exec ":call SetTitle_bash()"
"autocmd BufNewFile *.c,*.cpp exec ":call SetTitle_c()"
func SetTitle_bash()
    if &filetype == 'sh' 
        call setline(1, "\#!/bin/bash")
        call append(line("."), "\#####") 
        call append(line(".")+1, "\# File Name: ".expand("%")) 
        call append(line(".")+2, "\# Author: alen6516") 
        call append(line(".")+3, "\# Created Time: ".strftime("%Y-%m-%d")) 
        call append(line(".")+4, "\#####") 
        call append(line(".")+5, "")
	endif
endfunc
func SetTitle_py()
	if &filetype == 'py' 
        call setline(1,"\#!/usr/bin/python") 
        call append(line("."), "\# -*- coding: utf-8 -*-") 
        call append(line(".")+1, "\#####") 
        call append(line(".")+2, "\# File Name: ".expand("%")) 
        call append(line(".")+3, "\# Author: alen6516") 
        call append(line(".")+4, "\# Created Time: ".strftime("%Y-%m-%d")) 
        call append(line(".")+5, "\#####") 
        call append(line(".")+6, "")
    endif
endfunc 
func SetTitle_c()
    call setline(1,"/***") 
    call append(line("."), " File Name: ".expand("%")) 
    call append(line(".")+1, " Author: alen6516") 
    call append(line(".")+2, " Created Time: ".strftime("%Y-%m-%d")) 
    call append(line(".")+3, "***/") 
    call append(line(".")+4, "") 
    call append(line(".")+5, "#include <stdio.h>") 
    call append(line(".")+6, "#include <stdlib.h>") 
    call append(line(".")+7, "") 
endfunc 
" auto move to the end of the file
autocmd BufNewFile * normal G
"#### end new file title####
"###########################

" use F9 to compile and execute
autocmd filetype python nnoremap <F9> :w <bar> exec '!python '.shellescape('%')<CR>
autocmd filetype c nnoremap <F9> :w <bar> exec '!clear&&gcc '.shellescape('%').' -o '.shellescape('%:r').'&&./'.shellescape('%:r')<CR>
autocmd filetype cpp nnoremap <F9> :w <bar> exec '!clear;echo -n "====================";TEMP=`mktemp`;script $TEMP -e -q -c "g++ '.shellescape('%').' -std=c++11 -Wall -o '.shellescape('%:r').'" > /dev/null 2>&1 ;if [ $? == 0 ] ;then echo -e "\r\033[32m********************\033[0m";./'.shellescape('%:r').';else echo -e "\r\033[31mXXXXXXXXXXXXXXXXX\033[0m";cat $TEMP; fi'<CR>
"autocmd filetype c nnoremap <F8> :w <bar> exec '!clear&&gcc '.shellescape('%').' -o '.shellescape('%:r')<CR>
"autocmd filetype cpp nnoremap <F8> :w <bar> exec '!clear&&g++ '.shellescape('%').' -std=c++11 -Wall -o '.shellescape('%:r')<CR>
"nnoremap <F10> :w <bar> exec '!cat '.shellescape('%').'\| xclip -selection clipboard'<CR>
"nnoremap <F11> :w <bar> exec '!fish'<CR>

" vim scrolls php file slowly with cursorline, so turn off it when open php files
autocmd filetype php setlocal nocursorline          " by filetype detected by vim
autocmd BufRead,BufNewFile *.php set nocursorline   " by extension filename


" highlight when a line is overlegth
"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength /\%130v.\+/


" auto change tab's name when using tmux/screen
if &term == "screen" || &term == "xterm"
    let &titleold="bash"
    let &titlestring="vim " . expand("%:t")
    set t_ts=k
	set t_fs=\
	set title
endif


" show current function name in C program
fun! ShowFuncName()
  echohl ModeMsg
  echo getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bWn'))
  echohl None
endfun
map <leader>f :call ShowFuncName() <CR>


"#########################################
" config for ctags
"#########################################

" Must change input method to English then can jump

" change vim's work dir to the dir of the file, note some plugin may break
set autochdir

" set tags, the final ';' is important, it allows ctag to recursively search parent dir from current work dir
" ./tags means search from vim's current working dir
" note if not set autochdir, vim's working dir is user's current path
set tags=./.tags,./tags;

" still try to move tags to .git
"let tags_path=findfile(".git/tags", ";")
"let &tags=tags_path
"#########################################

let g:flag_open_pane = 0
fun! TogglePane()
	if g:flag_open_pane
		"echo "close pane"
		:wincmd q
		let g:flag_open_pane = 0
	else
		"echo "open pane"
		let g:flag_open_pane = 1
		:vs ~/doc/cmd/vim.cmd
	endif
endfun
map <leader>v :call TogglePane() <CR>


let g:flag_nu = 1
fun! ToggleNu()
	if g:flag_nu
		:set nonumber!
		:set foldcolumn=0
		let g:flag_nu = 0
	else
		:set number
		let g:flag_nu = 1
	endif
endfun
map <leader>n :call ToggleNu() <CR>


let g:flag_open_def = 0
fun! ToggleDef()
	if g:flag_open_def
		"echo "close def"
		:wincmd q
		let g:flag_open_def = 0
	else
		"echo "open def"
		let g:flag_open_def = 1
		:vsp 
		:exec('tag '.expand('<cword>'))
	endif
endfun
map <leader>g :call ToggleDef() <CR>
