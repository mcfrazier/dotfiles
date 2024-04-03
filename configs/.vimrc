" because tmux is being annoying with colors
set term=screen-256color

" making the editor look purrty
"colo default
syntax on
set number relativenumber

" convenience things
set expandtab
set shiftwidth=2
set smarttab
set autoindent
set smartindent
colorscheme gummybears

execute pathogen#infect()

" map auto complete for (, [, {, ', "
inoremap ( ()<esc>i
inoremap [ []<esc>i
inoremap { {}<esc>i
inoremap } {<esc>o}<esc>O
inoremap ' ''<esc>i
inoremap " ""<esc>i

" map ctrl-j to exit from above autocompletes"
inoremap <c-j> <esc>/[)}"'\]>]<cr>:nohl<cr>a

" map jk to esc to save my left pinky
inoremap jk <esc>
inoremap JK <esc>

nnoremap tv :vert term<cr>
nnoremap tt :term<cr>

" added on wsl to mute the beep
set noerrorbells visualbell t_vb=
