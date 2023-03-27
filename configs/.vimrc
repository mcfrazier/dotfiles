" because tmux is being annoying with colors
set term=screen-256color

" making the editor look purrty
colo default
set number relativenumber

" convenience things
set expandtab
set shiftwidth=2
set smarttab
set autoindent
set smartindent
colorscheme gummybears

execute pathogen#infect()

" adapted from:"
" https://vim.fandom.com/wiki/Making_Parenthesis_And_Brackets_Handling_Easier

" map auto complete for (, [, {, ', "
inoremap ( ()<esc>:let leavechar=")"<cr>i
inoremap [ []<esc>:let leavechar="]"<cr>i
inoremap { {}<esc>:let leavechar="}"<cr>i
inoremap } {<esc>o}<esc>:let leavechar="}"<cr>O
inoremap ' ''<esc>:let leavechar="'"<cr>i
inoremap " ""<esc>:let leavechar='"'<cr>i

"vnoremap _( <Esc>`>a)<Esc>`<i(<Esc>

" map ctrl-j to exit above autocompletes"
"imap <c-j> <esc>:exec "normal f" . leavechar<cr>a
inoremap <c-j> <esc>/[)}"'\]>]<cr>:nohl<cr>a

" map jk as esc to save my left pinky
" also JK if in caps :)
inoremap jk <esc>
inoremap JK <esc>

nnoremap tv :vert term<cr>
nnoremap tt :term<cr>

" added on wsl to mute the beep
"set visualbell
"set t_vb=
set noerrorbells visualbell t_vb=



" inoremap ( ()<Esc>i
" inoremap [ []<Esc>i
" inoremap { {<CR>}<Esc>O
" inoremap {<CR> {<CR>}<Esc>O
" inoremap { {}<Esc>i
" inoremap {;<CR> {<CR>};<Esc>O
" autocmd Syntax html,vim inoremap < <lt>><Esc>i| inoremap > <c-r>=ClosePair('>')<CR>
" autocmd Syntax php,vim inoremap < <lt>><Esc>i| inoremap > <c-r>=ClosePair('>')<CR>
" inoremap ) <c-r>=ClosePair(')')<CR>
" inoremap ] <c-r>=ClosePair(']')<CR>
" inoremap } <c-r>=CloseBracket()<CR>
" inoremap " <c-r>=QuoteDelim('"')<CR>
" inoremap ' <c-r>=QuoteDelim("'")<CR>
" 
" function ClosePair(char)
"  if getline('.')[col('.') - 1] == a:char
"  return "\<Right>"
"  else
"  return a:char
"  endif
" endf
" 
" function CloseBracket()
"  if match(getline(line('.') + 1), '\s*}') < 0
"  return "\<CR>}"
"  else
"  return "\<Esc>j0f}a"
"  endif
" endf
" 
" function QuoteDelim(char)
"  let line = getline('.')
"  let col = col('.')
"  if line[col - 2] == "\\"
"  "Inserting a quoted quotation mark into the string
"  return a:char
"  elseif line[col - 1] == a:char
"  "Escaping out of the string
"  return "\<Right>"
"  else
"  "Starting a string
"  return a:char.a:char."\<Esc>i"
"  endif
" endf
