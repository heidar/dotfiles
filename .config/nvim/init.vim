call plug#begin('~/.config/nvim/plugged')
  " Gruvbox theme
  Plug 'morhetz/gruvbox'

  " Airline statusbar
  Plug 'bling/vim-airline'

  " Show added/changed/removed lines in gutter
  Plug 'mhinz/vim-signify'

  " Shortcuts for commenting
  Plug 'tpope/vim-commentary'

  " Plugin for editing Rails applications
  Plug 'tpope/vim-rails'

  " Linter
  Plug 'w0rp/ale'

  " Tag management
  Plug 'ludovicchabant/vim-gutentags'

  " ctrl+p
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'

  " Tab completion
  Plug 'ajh17/VimCompletesMe'

  " Automatically pair brackets, quotes, etc
  Plug 'jiangmiao/auto-pairs'

  " Automatically add 'end' in ruby
  Plug 'tpope/vim-endwise'

  " Slim template support
  Plug 'slim-template/vim-slim'

  " Editorconfig support
  Plug 'editorconfig/editorconfig-vim'
call plug#end()

" Colorscheme
set background=dark
set termguicolors
colorscheme gruvbox

" Files/Backups
set backup " make backup file
set backupdir=~/.config/nvim/backup " where to put backup files
set directory=~/.config/nvim/temp " directory for temp files

" Indentation
set expandtab
set shiftwidth=2
set softtabstop=2
set cc=80

" Gutter
set number

" Always show tabs
set listchars=tab:▸\ ,trail:·
set list

" Remove trailing whitespace
function! <SID>StripTrailingWhitespaces()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  %s/\s\+$//e
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

" Automatically remove trailing whitespace on write for any file type (*)
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" Buffers
set hidden
nmap <C-h> :bp<CR>
nmap <C-l> :bn<CR>
nmap <C-w> :bd<CR>

" Airline
let g:airline_theme = 'gruvbox'
set noshowmode
let g:airline_powerline_fonts = 1
let g:airline#extensions#hunks#enabled = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1

" Leader maps
let mapleader = "\<Space>"
nnoremap <Leader>w :w<CR>

" Disable mouse
set mouse=

" Binding to unhighlight search
nnoremap <leader>h :noh<cr>

" FZF - Finding files like ctrlp
nnoremap <c-p> :FZF<cr>
nnoremap <c-i> :Ag<cr>

" Set tab completion to use tags
let b:vcm_tab_complete = 'tags'

" Ale
let g:ale_lint_on_enter = 0
let g:ale_sign_error = '⚠'
let g:ale_sign_warning = '⚠'
let g:ale_sign_column_always = 1
let g:ale_lint_delay = 1000

highlight clear ALEErrorSign
highlight clear ALEWarningSign

hi ALEErrorSign   guibg=#501010 ctermbg=52 guifg=#FD3F44 ctermfg=203
hi ALEWarningSign guibg=#503010 ctermbg=58 guifg=#FF9800 ctermfg=208
