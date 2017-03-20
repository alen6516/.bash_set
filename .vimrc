"##### shortcut ##########################
"## F2    --> number/no number
"## space --> page doen
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

"###############
"#### color ####
set t_Co=256
"colorscheme torte # set color style (select from /usr/share/vim/vimNN/colors/ , vimNN is the version number of your vim)

set cursorline
"hi CursorLine cterm=none ctermbg=DarkBlue ctermfg=White  "set the style of cursorline 

set hlsearch        " highlight the searching result

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
"#### end of shortcut ####
"#########################

"##########################
"#### custom file title ######
autocmd BufNewFile *.py,*.sh exec ":call SetTitle()"
func SetTitle()
    if &filetype == 'sh' 
        call setline(1,"\#####") 
        call append(line("."), "\# File Name: ".expand("%")) 
        call append(line(".")+1, "\# Author: alen6516") 
        call append(line(".")+2, "\# Created Time: ".strftime("%Y-%m-%d")) 
        call append(line(".")+3, "\#####") 
        call append(line(".")+4, "\#!/bin/bash")
        call append(line(".")+5, "")
    else
        call setline(1,"\#####") 
        call append(line("."), "\# File Name: ".expand("%")) 
        call append(line(".")+1, "\# Author: alen6516") 
        call append(line(".")+2, "\# Created Time: ".strftime("%Y-%m-%d")) 
        call append(line(".")+3, "\#####") 
        call append(line(".")+4, "") 
    endif
endfunc 
" auto move to the end of the file
autocmd BufNewFile * normal G
"#### end new file title####
"###########################

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif
