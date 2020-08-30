call plug#begin('~/.config/nvim/plugged')
  " nord theme
  Plug 'arcticicestudio/nord-vim'

  " airline status bar
  Plug 'vim-airline/vim-airline'

  " show added/changed/removed lines in gutter
  Plug 'mhinz/vim-signify'

  " shortcuts for commenting
  Plug 'tpope/vim-commentary'

  " ctrl+p
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'

  " automatically pair brackets, quotes, etc
  Plug 'jiangmiao/auto-pairs'

  " editorconfig support
  Plug 'editorconfig/editorconfig-vim'
call plug#end()

" set nord as the color scheme
colorscheme nord

" show buffers line at top
let g:airline#extensions#tabline#enabled = 1

" enable fancy powerline fonts
let g:airline_powerline_fonts = 1

" make backup file
set backup
" where to put backup files
set backupdir=~/.config/nvim/backup
set directory=~/.config/nvim/tmp

" indentation
set expandtab
set shiftwidth=2
set softtabstop=2
set cc=80
set tw=79

" gutter
set number

" always show tabs
set listchars=tab:▸\ ,trail:·
set list

" remove trailing whitespace
function! <SID>StripTrailingWhitespaces()
  " preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " do the business:
  %s/\s\+$//e
  " clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

" automatically remove trailing whitespace on write for any file type (*)
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" buffer navigation
set hidden
nmap <C-h> :bp<CR>
nmap <C-l> :bn<CR>
nmap <C-w> :bd<CR>

" leader maps
let mapleader = "\<Space>"
nnoremap <Leader>w :w<CR>

" binding to unhighlight search
nnoremap <leader>h :noh<cr>

" FZF - finding files like ctrlp
nnoremap <c-p> :FZF<cr>
nnoremap <c-i> :Ag<cr>

" mouse scrolling
set mouse=a
