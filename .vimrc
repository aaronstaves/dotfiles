set nocp
execute pathogen#infect()

""" START keymappings.vim

:nmap \l :setlocal number!<CR>
:nmap \o :set paste!<CR>

:nmap j gj
:nmap k gk

:cnoremap <C-a>  <Home>
:cnoremap <C-b>  <Left>
:cnoremap <C-f>  <Right>
:cnoremap <C-d>  <Delete>
:cnoremap <M-b>  <S-Left>
:cnoremap <M-f>  <S-Right>
:cnoremap <M-d>  <S-right><Delete>
:cnoremap <Esc>b <S-Left>
:cnoremap <Esc>f <S-Right>
:cnoremap <Esc>d <S-right><Delete>
:cnoremap <C-g>  <C-c>

:nmap \q :nohlsearch<CR>

:nmap <C-e> :e#<CR>

:nmap <C-n> :bnext<CR>
:nmap <C-p> :bprev<CR>

:nmap ; :CtrlPBuffer<CR>


"perl mappings
"comment and uncomment offa mark a
map ,cb :'a,.s/^/#/<CR>:nohlsearch<CR>
map ,ucb :'a,.s/^#//<CR>:nohlsearch<CR>
map ,pt :!perltidy<CR>

"perl check syntax
map ,pc :!perl -c %<CR>


""" END perl.vim

""" START settings.vim

syntax on
filetype plugin indent on

:set noundofile
:set incsearch
:set ignorecase
:set smartcase
:set hlsearch

:let g:Powerline_symbols = 'fancy'
:set hidden
:set tabstop=2
:set shiftwidth=2
:set softtabstop=0 noexpandtab


"set nocompatible   " Disable vi-compatibility
:set laststatus=2   " Always show the statusline
"set encoding=utf-8 " Necessary to show Unicode glyphs

""" END settings.vim

""" START whitespace.vim

" Highlight trailing white space in command mode
highlight ExtraWhitespace ctermbg=red guibg=red
au ColorScheme * highlight ExtraWhitespace guibg=red
"au BufEnter * match ExtraWhitespace /\s\+$/
"au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
"au InsertLeave * match ExtraWhiteSpace /\s\+$/
"autocmd FileType vim,perl,c,cpp,python,ruby,java autocmd BufWritePre <buffer> :%s/\s\+$//e


""" END whitespace.vim

""" START powerline
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup
""" END powerline
