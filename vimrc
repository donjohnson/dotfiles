runtime! debian.vim
set ignorecase          " Do case insensitive matching
syntax on
"set number
set tildeop
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>
noremap <F8> :Geeknote<cr>
set laststatus=2
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
if filereadable("/etc/vim/jhdark.vim")
  source /etc/vim/jhdark.vim
endif
set tabstop=2
set shiftwidth=2
set expandtab
set smarttab
function! ToggleCursorline()
  if &cursorline == 1
    set nocursorline
  else
    set cursorline
  endif
endfunction
nnoremap <space> :call ToggleCursorline()<cr>
au BufNewFile,BufRead *.sls set filetype=yaml

nmap f xi<C-R>=strftime("x [%a %b%d %I:%M%p]")<CR><Esc> " map f to replace below char with timestamp
imap <F3> <C-R>=strftime("x [%Y/%m/%d %a %I:%M%p]")<CR>

set updatetime=1000
autocmd CursorHold * silent w
