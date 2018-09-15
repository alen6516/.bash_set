" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" general plug
" {
    Plug 'scrooloose/nerdtree'
    " config {
        " open nerdtree automatically when vim starts up
        "autocmd vimenter * NERDTree
        
        " open a NERDTree automatically when vim starts up if no files were specified
        autocmd StdinReadPre * let s:std_in=1
        autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
        
        " open NERDTree automatically when vim starts up on opening a directory
        autocmd StdinReadPre * let s:std_in=1
        autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
        
        " toggle (default jump to the nerdtree window)
        "map E :NERDTreeToggle<CR>
        
        " toggle (jump back to the file window)
        map E :NERDTreeToggle<CR>:wincmd p<CR>
     
        " close vim if the only window left open is a NERDTree
        autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
        
        " change default arrows
        let g:NERDTreeDirArrowExpandable = '▸'
        let g:NERDTreeDirArrowCollapsible = '▾'
        
        " change default nerdtree window size
        let g:NERDTreeWinSize=20
    " }
    "  
    " usage {
        "press <Enter> to open new file in buffer
        "press "t" to open new file in a new tab
    " }
   
    Plug 'Nopik/vim-nerdtree-direnter'
    " config {
        " allow nerdtree to use <ENTER> to open file in a new tab
        let NERDTreeMapOpenInTab='<ENTER>'
    " } 

    Plug 'itchyny/lightline.vim'
    " config {
    "
    " }


    Plug 'tpope/vim-surround'
    "config {
    " 
    "}
    "
    "usage{
        " change surrounding
            " cs'"      => change ' to "
        
        " delete surrounding
            " ds"       => remove "
            
        " you surrounding
            " ysiw"     => add "
           
        " you surrounding
            " csw"      => add "
    "}


    "Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    "Plug 'junegunn/fzf.vim'
    
    
    "Plug 'wting/gitsessions.vim'
    " config {
    " }
    
    Plug 'terryma/vim-multiple-cursors'
    " config {
    " 
        " if installed Neocomplete, uncomment following 
        " {
            "function! Multiple_cursors_before()
            "    if exists(':NeoCompleteLock')==2
            "        exe 'NeoCompleteLock'
            "    endif
            "endfunction
            "
            "function! Multiple_cursors_after()
            "    if exists(':NeoCompleteUnlock')==2
            "        exe 'NeoCompleteUnlock'
            "    endif
            "endfunction
        " }
    " }
    "
    " usage{
	    " start: <C-n> start multicursor and add a virtual cursor + selection on the match
        " next:  <C-n> add a new virtual cursor + selection on the next match
        " skip:  <C-x> skip the next match
        " prev:  <C-p> remove current virtual cursor + selection and go back on previous match
        " select all: <A-n> start muticursor and directly select all matches 
    " }
    
    
    Plug 'easymotion/vim-easymotion'
    " leader key is \
    " config {
        let g:EasyMotion_smartcase = 1
        let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion
        map <Leader><leader>h <Plug>(easymotion-linebackward)
        map <Leader><Leader>j <Plug>(easymotion-j)
        map <Leader><Leader>k <Plug>(easymotion-k)
        map <Leader><leader>l <Plug>(easymotion-lineforward)
        " 重复上一次操作, 类似repeat插件, 很强大
        map <Leader><leader>. <Plug>(easymotion-repeat)
    " }
    "
    " usage {
        "<leader> <leader> w
        "<leader> <leader> b
        "<leader> <leader> s
        "
    " }
    
    Plug 'mbbill/undotree'
    " config {
        " toggle
        nnoremap U :UndotreeToggle<cr>

        " set window size
        let g:undotree_SplitWidth = 30

        " automatically focus to undotree window after toggle
        let g:undotree_SetFocusWhenToggle = 1
    " }
    
    Plug 'senderle/restoreview'
    " config {
    " }
   
    Plug 'gcmt/wildfire.vim'
    " config {
		" This selects the next closest text object.
		map <ENTER> <Plug>(wildfire-fuel)

		" This selects the previous closest text object.
		vmap <BS> <Plug>(wildfire-water)
    " }
    
   
    Plug 'Yggdroot/indentLine' 
    " config {
        " change indent char
        let g:indentLine_char = '¦'

        " toggle
        nnoremap I :IndentLinesToggle<cr>
    " }

" }

" programming plug
" {
    Plug 'majutsushi/tagbar'
    " depending on ctags ( $ apt install ctags )    
    " config {
        " toggle
        nmap T :TagbarToggle<cr>
        
        " set window on left side
        let g:tagbar_left = 0 
        
        " set window size
        let g:tagbar_width = 20

        " auto focus to the windows
        let g:tagbar_autofocus = 0
    
        " do not sort tags
        let g:tagbar_sort = 0
    " }
    
    "Plug 'chazy/cscope_maps'
    " config {
    " }
    "
    " usage {
    "   $ cscope -Rqb 
    "
    "   find : Query for a pattern            (Usage: find c|d|e|f|g|i|s|t name)
    "          c: Find functions calling this function
    "          d: Find functions called by this function
    "          e: Find this egrep pattern
    "          f: Find this file
    "          g: Find this definition
    "          i: Find files #including this file
    "          s: Find this C symbol
    "          t: Find this
    "          text string
    "
    "   move cursor to a target statement and press Ctrl + \ + c|d|e|f|g|i|s|t
    "   move cursor to a function and press Ctrl + ] , it will jump to the definition, Ctrl + T return
    " }
 
    Plug 'wesleyche/SrcExpl'
    " config {
    	" // The switch of the Source Explorer 
     	nmap S :SrcExplToggle<CR> 
    
        " // Set the height of Source Explorer window 
        let g:SrcExpl_winHeight = 8 
        
        " // Set 100 ms for refreshing the Source Explorer 
        let g:SrcExpl_refreshTime = 100 
        
        " // Set "Enter" key to jump into the exact definition context 
        "let g:SrcExpl_jumpKey = "<ENTER>" 
        
        " // Set "Space" key for back from the definition context 
        "let g:SrcExpl_gobackKey = "<SPACE>" 
        
        " // In order to avoid conflicts, the Source Explorer should know what plugins except
        " // itself are using buffers. And you need add their buffer names into below list
        " // according to the command ":buffers!"
        let g:SrcExpl_pluginList = [    \
        	    "__Tag_List__",         \
        	    "_NERD_tree_",          \
        	    "Source_Explorer"       \
        	]
        
        " // The color schemes used by Source Explorer. There are five color schemes
        " // supported for now - Red, Cyan, Green, Yellow and Magenta. Source Explorer
        " // will pick up one of them randomly when initialization.
        let g:SrcExpl_colorSchemeList = [   \
        		"Red",                    \
        		"Cyan",                   \
        		"Green",                  \
        		"Yellow",                 \
        		"Magenta"                 \
        	]
        
        " // Enable/Disable the local definition searching, and note that this is not 
        " // guaranteed to work, the Source Explorer doesn't check the syntax for now. 
        " // It only searches for a match with the keyword according to command 'gd' 
        let g:SrcExpl_searchLocalDef = 1 
        
        " // Workaround for Vim bug @https://goo.gl/TLPK4K as any plugins using autocmd for
        " // BufReadPre might have conflicts with Source Explorer. e.g. YCM, Syntastic etc.
        let g:SrcExpl_nestedAutoCmd = 1
        
        " // Do not let the Source Explorer update the tags file when opening 
        let g:SrcExpl_isUpdateTags = 0 
        
        " // Use 'Exuberant Ctags' with '--sort=foldcase -R .' or '-L cscope.files' to 
        " // create/update the tags file 
        let g:SrcExpl_updateTagsCmd = "ctags --sort=foldcase -R ." 
        
        " // Set "<F12>" key for updating the tags file artificially 
        "let g:SrcExpl_updateTagsKey = "<F12>" 
        
        " // Set "<F11>" key for displaying the previous definition in the jump list 
        "let g:SrcExpl_prevDefKey = "<F11>" 
        
        " // Set "<F10>" key for displaying the next definition in the jump list 
        "let g:SrcExpl_nextDefKey = "<F10>"   
    " }

    "Plug 'w0rp/ale' 
    " better than syntastic, but vim 8 is required !!
    " config {
    " }
    
    Plug 'vim-syntastic/syntastic'
    " config {
        " recommanded settings
        set statusline+=%#warningmsg#
        set statusline+=%{SyntasticStatuslineFlag()}
        set statusline+=%*
        let g:syntastic_always_populate_loc_list = 1
        let g:syntastic_auto_loc_list = 1
        let g:syntastic_check_on_open = 0
        let g:syntastic_check_on_wq = 1
    
        " add support to python
        let g:syntastic_python_checkers = ['pylint']
    
        " disable warning
        let g:syntastic_quiet_messages={'level':'warningis'}
	
	    " toggle
        nmap R :call SyntasticToggle()<CR>
        let g:syntastic_is_open = 0
        function! SyntasticToggle()
           if g:syntastic_is_open == 1
               SyntasticReset
               let g:syntastic_is_open = 0
           else
               SyntasticCheck
               let g:syntastic_is_open = 1
           endif
        endfunction
    " }
    
    " usage {
    "   :lnext     = jump to next error
    "   :lprevious = jump to previous error
    "
    "   :lopen     = open location window
    "   :lclose    = close location window
    " }


    Plug 'scrooloose/nerdcommenter'
    " config {
    	" default leader key
        let mapleader='\'

    	" Add spaces after comment delimiters by default
		let g:NERDSpaceDelims = 0
		
		" Use compact syntax for prettified multi-line comments
		let g:NERDCompactSexyComs = 1
		
		" Align line-wise comment delimiters flush left instead of following code indentation
		let g:NERDDefaultAlign = 'left'
		
		" Set a language to use its alternate delimiters by default
		let g:NERDAltDelims_java = 1
		
		" Add your own custom formats or override the defaults
		let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
		
		" Allow commenting and inverting empty lines (useful when commenting a region)
		let g:NERDCommentEmptyLines = 1
		
		" Enable trimming of trailing whitespace when uncommenting
		let g:NERDTrimTrailingWhitespace = 1
		
		" Enable NERDCommenterToggle to check all selected lines is commented or not 
		let g:NERDToggleCheckAllLines = 1
    " }
    "
    " usage {
    "	<leader> c <space> ==> comment/uncomment
    " }

    Plug 'junegunn/vim-easy-align'
    " config {
     	" Start interactive EasyAlign in visual mode (e.g. vipga)
     	xmap ga <Plug>(EasyAlign)
    
     	" Start interactive EasyAlign for a motion/text object (e.g. gaip)
     	nmap ga <Plug>(EasyAlign)
    " }
    "
    " usage {
    " 	select block, press 'ga' 
    " 		press '=', it will align via the first =
    " 		press '2=', it will align via the second =
    " }

"}

" python plug
" {
"   "Plug python_match
" }

" Initialize plugin system
call plug#end()
filetype indent off " avoid vim-plug to auto indent

set bg=dark
set nu
set ruler           " turn on the display of coordination at right-bottom cornor
set incsearch       " jump to the searching pattern while still typing
set ic              " ignore the case of searching pattern
set ai              " auto indent
set scrolloff=3     " preserve several lines when scrolling
set tabstop=4       " the definition for a tab of vim
set shiftwidth=4    " the width of auto indent
set expandtab       " expand a tab as several spaces
"set mouse=a         " allow using mouse to move the cursor
set encoding=utf-8

set foldenable      " enable fold mode
set foldmethod=manual   " zz to create; zo to open; zc to close

" #### line number color #### 
set cursorline
hi LineNr cterm=NONE ctermfg=DarkGrey ctermbg=NONE
hi CursorLineNR term=bold cterm=bold ctermfg=yellow

"#### set shortcut #######
nmap N :set nonumber!<CR>:set foldcolumn=0<CR>
nmap <Space> 10j
nmap <BS> 10k
nmap <C-h> :noh<CR>
nmap <C-S-g> gg=G

" quick quit
nmap qqq :q<cr>

" insert line
"nmap O o<ESC>

" move to header/tailer
"nmap > $
"nmap < 0

" window switching
"nmap w<Right> <C-w><Right>
"nmap w<Left>  <C-w><Left>
"nmap w<Up>    <C-w><Up>
"nmap w<Down>  <C-w><Down>
"nmap ww       <C-w>w

" tab switching
"nmap t<Right> gt
"nmap t<Left> gT

"###########################################
" enable copy between different vim instance

map <C-y> <Nop>
map <C-y> :w! /tmp/vitmp<CR>

map <C-p> <Nop>
map <C-p> :r! cat /tmp/vitmp<CR>

vmap <C-y> :w! /tmp/vitmp<CR>
nmap <C-p> :r! cat /tmp/vitmp<CR>
"###########################################

"#####################
"# indent & unindent #
nmap <tab> V>
nmap <s-tab> V<
vmap <tab> >gv
vmap <s-tab> <gv
imap <s-tab> <Esc>V<i

"imap <tab> <C-n>   " use tab to show completion
"#####################


"###############
"#### color ####
set t_Co=256
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

"autocmd filetype python nnoremap <F9> :w <bar> exec '!python '.shellescape('%')<CR>
"autocmd filetype c nnoremap <F9> :w <bar> exec '!clear&&gcc '.shellescape('%').' -o '.shellescape('%:r').'&&./'.shellescape('%:r')<CR> 
"autocmd filetype cpp nnoremap <F9> :w <bar> exec '!clear;echo -n "====================";TEMP=`mktemp`;script $TEMP -e -q -c "g++ '.shellescape('%').' -std=c++11 -Wall -o '.shellescape('%:r').'" > /dev/null 2>&1 ;if [ $? == 0 ] ;then echo -e "\r\033[32m********************\033[0m";./'.shellescape('%:r').';else echo -e "\r\033[31mXXXXXXXXXXXXXXXXX\033[0m";cat $TEMP; fi'<CR>
"autocmd filetype c nnoremap <F8> :w <bar> exec '!clear&&gcc '.shellescape('%').' -o '.shellescape('%:r')<CR> 
"autocmd filetype cpp nnoremap <F8> :w <bar> exec '!clear&&g++ '.shellescape('%').' -std=c++11 -Wall -o '.shellescape('%:r')<CR>
"nnoremap <F10> :w <bar> exec '!cat '.shellescape('%').'\| xclip -selection clipboard'<CR>
"nnoremap <F11> :w <bar> exec '!fish'<CR>
