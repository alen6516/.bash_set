syntax on
set nocompatible
filetype plugin on
"source ~/.vim_plug

" Enable commands(:tags, ctrl-]) in cscope database; needed even with plugin gtags-cscope.vim
set cscopetag

" Tell vim to use gtags-cscope as cscope
set cscopeprg='gtags-cscope'
" For using ^] ^t in gtags-cscope (no need to install ctags), no need if source .cscope_maps.vim
cs add GTAGS
" Map cs command to ctrl-\ short-cut
source ~/.cscope_maps.vim

"" For using ^] ^t in cscope
"cs add cscope.out

"## following logic should work, but not {
"" For using ^] ^t in gtags-cscope (no need to install ctags)
"if findfile("GTAGS", ".;")
"    cs add GTAGS
"
"" For using ^] ^t in cscope
"elseif findfile("cscope.out", ".;")
"    cs add cscope.out
"
"endif
"## }


"## no need {
"set tags=./tags,./TAGS,tags;~,TAGS;~

"#########################################
" config for ctags
"#########################################

" Must change input method to English then can jump

" change vim's work dir to the dir of the file, note some plugin may break
"set autochdir

" set tags, the final ';' is important, it allows ctag to recursively search parent dir from current work dir
" ./tags means search from vim's current working dir
" note if not set autochdir, vim's working dir is user's current path
"set tags=./.tags,./tags;

" still try to move tags to .git
"let tags_path=findfile(".git/tags", ";")
"let &tags=tags_path
"#########################################
"## }


" variables use by gtags.vim plugin
let GtagsCscope_Auto_Load = 1   " needed if want to use <C-]>
let CtagsCscope_Auto_Map = 1
let GtagsCscope_Auto_Map = 1    " To use the default key/mouse mapping
let GtagsCscope_Quiet = 1
"let GtagsCscope_Ignore_Case = 1        " To ignore letter case when searching


set bg=dark
set nu
set ruler           " turn on the display of coordination at right-bottom cornor
set incsearch       " jump to the searching pattern while still typing
set ic              " ignore the case of searching pattern
set ai              " auto indent
set scrolloff=3     " preserve several lines when scrolling
"set cindent         " cindent can identify C and Java and do intent (but not useful)
set tabstop=4       " means the width of a tab appears to be
set shiftwidth=4    " the width of auto indent
set expandtab       " expand a new tab as several spaces, to transfer old tab, use :retab or :%s/^I/    /gc
"set softtabstop=4  " not sure, don't use
" set noexpandtab   " don't expand tab to spaces
" %retab!           " recover spaces to tab, ! means to process all tabs in a line
"set mouse=a        " allow using mouse to move the cursor
set encoding=utf-8
set splitright		" set split window to right-hand side
"set shortmess+=A   " don't show swap file exist warning

packadd! matchit
runtime macros/matchit.vim			" enable vim customized pair pattern jump
let b:match_words='\<foo\>:\<bar\>'	" let vim match 'begin' and 'end' by % (but don't know why it doesn't work in .vimrc, need to type it manually in vim)
let b:match_ignorecase = 1 				" ignore the case of the pattern


" Tmux auto rename window name {
autocmd BufEnter * call system("tmux rename-window " . expand("%:t"))
autocmd VimLeave * call system("tmux rename-window bash")
autocmd BufEnter * let &titlestring = ' ' . expand("%:t")
set title
" }


set foldenable     		" enable fold mode
set foldmethod=manual 	" zz to create; zo to open; zc to close
" fold command under visual mode:
" 	zf   - create
" 	za   - toggle fold
" 	zo   - open fold
" 	zc   - close fold
" 	zM   - close all fold
" 	zR   - open all fold
" 	zd   - delete fold
" 	zE   - delete all fold
" 	zj   - move to previous fold
" 	zk   - move to next fold
" 	zn   - disable fold
" 	zN   - enable fold
" 	zfa( - fold () area
" 	:mkview - save current fold
" 	:loadview - load fold when open this file


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

nmap <C-j> 10j
nmap <C-k> 10k
nmap <C-l> 20l
nmap <C-h> 20h
nmap <BS> 15h
" bind <BS> is tricky, because in tmux, <C-h> sends ^? to the terminal, which is <BS>

"shift + arrow key is annoying
map <S-Down> <Nop>
map <S-Up> <Nop>

" ctrl-q for visual-block is annoying
nmap <C-q> <Nop>

" shift-tab maps to 4 spaces in insert mode
inoremap <S-Tab> <Space><Space><Space><Space>

nmap <leader>h :noh<CR>
nmap <leader>m :marks<CR>
"nmap <C-S-g> gg=G

" show full path of current file
map <leader>F :echo expand('%:p') <CR>
" :f only show file name, and 1-Ctrl-g I need to tap enter again, not
" convenient

" quick quit
nmap qqq :q!<cr>
nmap <leader>qq :q!<cr>

" window switching
"nmap <leader>w<Right> <C-w><Right>
"nmap <leader>w<Left>  <C-w><Left>
"nmap <leader>w<Up>    <C-w><Up>
"nmap <leader>w<Down>  <C-w><Down>
"nmap <leader>ww       <C-w>w

" YouCompleteMe FixIt
nmap <leader>x :YcmCompleter FixIt<CR>

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
"nmap <tab> V>
"nmap <s-tab> V<
"vmap <tab> >gv
"vmap <s-tab> <gv
"imap <s-tab> <Esc>V<i

"###############
"#### color ####
if !has('gui_running')
	set t_Co=256
endif
"colorscheme torte # set color style (select from /usr/share/vim/vimNN/colors/ , vimNN is the version number of your vim)


set hlsearch        " highlight the searching result
hi Search guibg=Yellow guifg=Black ctermbg=Yellow ctermfg=Black

" remove _ from the markdown pattern
syn match markdownError "\w\@<=\w\@="

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


" highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
"match ExtraWhitespace /\S\zs\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\S\zs\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\S\zs\s\+$/
autocmd BufWinLeave * call clearmatches()


" Forcing vimdiff to wrap lines
au VimEnter * if &diff | execute 'windo set wrap' | endif


" Let vim open at previously leaving position
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif


" auto change tab's name when using tmux/screen
" !! this block may cause line to overlap !! disable for now
"if &term == "screen" || &term == "xterm"
"    let &titleold="bash"
"    let &titlestring="vim " . expand("%:t")
"    set t_ts=k
"    set t_fs=\
"    set title
"endif


" show current function name in C program
fun! ShowFuncName()
  echohl ModeMsg
  echo getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bWn'))
  echohl None
endfun
map <leader>f :call ShowFuncName() <CR>


" Just a example
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

" open my vim help doc in a vim pane
let g:flag_open_vim_doc = 0
fun! ToggleVimDoc()
	if g:flag_open_vim_doc
		"echo "close vim doc"
		:wincmd q
		let g:flag_open_vim_doc = 0
	else
		"echo "open vim doc"
		let g:flag_open_vim_doc = 1
		:vs ~/doc/cmd/vim.cmd
	endif
endfun
map <leader>v :call ToggleVimDoc() <CR>


" Just a example
let g:flag_open_cword = 0
fun! ToggleCWord()
    if g:flag_open_cword
        echo "close cword"
        :wincmd q
        let g:flag_open_cword = 0
    else
        let g:flag_open_cword = 1
        echo "open cword"
        :vs<CR> :exec("tag ".expand("<cword>"))<CR>
    endif
endfun
map <leader>w :call ToggleCWord() <CR>


" Toggle line number
"let g:flag_nu = 1
"fun! ToggleNu()
"	if g:flag_nu
"		:set nonumber!
"		:set foldcolumn=0
"		let g:flag_nu = 0
"	else
"		:set number
"		let g:flag_nu = 1
"	endif
"endfun
"map <leader>n :call ToggleNu() <CR>
map <leader>n :set nu! <CR>


" use ctag tag file to open function defination in pane
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


" jump to history record place
function! GotoJump()
  jumps
  let j = input("Please select your jump: ")
  if j != ''
    let pattern = '\v\c^\+'
    if j =~ pattern
      let j = substitute(j, pattern, '', 'g')
      execute "normal " . j . "\<c-i>"
    else
      execute "normal " . j . "\<c-o>"
    endif
  endif
endfunction
map <leader>j :call GotoJump() <CR>


" Toggle set an 80 column border for good coding style
let g:flag_cc = 0
fun! ToggleCC()
        if g:flag_cc
                :set cc=0
                let g:flag_cc = 0
        else
                let g:flag_cc = 1
                :set cc=80
        endif
endfun
map <leader>c :call ToggleCC() <CR>


" -- git command on current file
fun! GitCommand(command)
  silent! !clear
  exec "!git " . a:command . " % | vim +" . line(".") . " -"
endfun
" -- git diff for current file
"map <leader>d :call GitCommand("diff") <CR>

" -- git log for current file
"map <leader>l :call GitCommand("log -p") <CR>

" -- git blame for current file
map <leader>b :call GitCommand("blame") <CR>

" git show the word under cursor as the commit id
map <leader>s :!git show <cWORD> \| vim - <CR>
