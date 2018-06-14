"##### shortcut ##########################
"## F2        --> number/no number
"## space     --> half page down
"## indent    --> Contrl + Shift + g
"## C-n       --> close highlight search hit (:noh)
"## fold
"###  selecting lines, then use zf to create fold
"###  zo to open fold, and zc to close
"#########################################


"syntax enable      " turn on vim highlight for code, note this line should be upper then the line hi
set nocompatible    " don't be compatible to vi

set nu
set ruler           " turn on the display of coordination at right-bottom cornor
set incsearch       " jump to the searching pattern while still typing
set ic              " ignore the case of searching pattern
set tabstop=4       " the definition for a tab of vim
set shiftwidth=4    " the width of auto indent
set expandtab       " expand a tab as several spaces
"set mouse=a         " allow using mouse to move the cursor
set encoding=utf-8

set foldenable      " enable fold mode
set foldmethod=manual

"###########################################
" enable copy between different vim instance
vmap <C-y>y :w! /tmp/vitmp<CR>                                                                           
nmap <C-p>p :r! cat /tmp/vitmp<CR>
"###########################################

"###############
"#### color ####
set t_Co=256
"colorscheme torte # set color style (select from /usr/share/vim/vimNN/colors/ , vimNN is the version number of your vim)

set cursorline
"hi CursorLine cterm=none ctermbg=DarkBlue ctermfg=White  "set the style of cursorline 

set hlsearch        " highlight the searching result
hi Search guibg=Yellow guifg=Black ctermbg=Yellow ctermfg=Black

"##### set the style of status line ####
set laststatus=2    " turn on the status line of vim, set 1 to turn 0ff
set statusline=%#filepath#[%{expand('%:p')}]%#filetype#[%{strlen(&fenc)?&fenc:&enc},\ %{&ff},\ %{strlen(&filetype)?&filetype:'plain'}]%#filesize#%{FileSize()}%{IsBinary()}%=%#position#%c,%l/%L\ [%3p%%]

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

"#########################
"#### set shortcut #######
nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>
nnoremap <Space> <C-d>
nnoremap <C-n> :noh<CR>
nnoremap <C-S-g> gg=G
"#### end of shortcut ####
"#########################

"###########################
"#### custom file title ####
autocmd BufNewFile *.py,*.sh exec ":call SetTitle_1()"
autocmd BufNewFile *.c,*.cpp exec ":call SetTitle_2()"
func SetTitle_1()
    if &filetype == 'sh' 
        call setline(1, "\#!/bin/bash")
        call append(line("."), "\#####") 
        call append(line(".")+1, "\# File Name: ".expand("%")) 
        call append(line(".")+2, "\# Author: alen6516") 
        call append(line(".")+3, "\# Created Time: ".strftime("%Y-%m-%d")) 
        call append(line(".")+4, "\#####") 
        call append(line(".")+5, "") 
    else
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
func SetTitle_2()
    call setline(1,"/***") 
    call append(line("."), " File Name: ".expand("%")) 
    call append(line(".")+1, " Author: alen6516") 
    call append(line(".")+2, " Created Time: ".strftime("%Y-%m-%d")) 
    call append(line(".")+3, "***/") 
    call append(line(".")+4, "") 
    call append(line(".")+5, "#include <stdio.h>") 
    call append(line(".")+6, "#include <stdint.h>") 
    call append(line(".")+7, "") 
endfunc 
" auto move to the end of the file
autocmd BufNewFile * normal G
"#### end new file title####
"###########################

"if filereadable(expand("~/.vimrc.bundles"))
"  source ~/.vimrc.bundles
"endif

autocmd filetype python nnoremap <F9> :w <bar> exec '!python '.shellescape('%')<CR>
autocmd filetype c nnoremap <F9> :w <bar> exec '!clear&&gcc '.shellescape('%').' -o '.shellescape('%:r').'&&./'.shellescape('%:r')<CR> 
autocmd filetype cpp nnoremap <F9> :w <bar> exec '!clear;echo -n "====================";TEMP=`mktemp`;script $TEMP -e -q -c "g++ '.shellescape('%').' -std=c++11 -Wall -o '.shellescape('%:r').'" > /dev/null 2>&1 ;if [ $? == 0 ] ;then echo -e "\r\033[32m********************\033[0m";./'.shellescape('%:r').';else echo -e "\r\033[31mXXXXXXXXXXXXXXXXX\033[0m";cat $TEMP; fi'<CR>
autocmd filetype c nnoremap <F8> :w <bar> exec '!clear&&gcc '.shellescape('%').' -o '.shellescape('%:r')<CR> 
autocmd filetype cpp nnoremap <F8> :w <bar> exec '!clear&&g++ '.shellescape('%').' -std=c++11 -Wall -o '.shellescape('%:r')<CR>
nnoremap <F10> :w <bar> exec '!cat '.shellescape('%').'\| xclip -selection clipboard'<CR>
nnoremap <F11> :w <bar> exec '!fish'<CR>
