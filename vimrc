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
set laststatus=2
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
if filereadable("/etc/vim/jhdark.vim")
  source /etc/vim/jhdark.vim
endif
