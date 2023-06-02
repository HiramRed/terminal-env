let mapleader = "\<space>"
let loaded_matchparen=1       " do no highlight matched pairs

setl foldmethod=marker

" set pyxversion=3

if !has('nvim')
  language en_US
endif

" netrw
let g:netrw_banner=0	    " diable banner

" vim gui
let macvim_skip_colorscheme=1
set guifont=Comic\ Mono:h21
set guicursor=n-v-c-sm-i:block-blinkon0,ve:ver25,r-cr-o:hor20


set path=.
set path+=**
set wildignore+=*node_modules/*


" main ------------------------------
set autoindent
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=8


" normal settings ------------------------------
set nobackup       " no backup files
set noswapfile     " no swap files
set nowritebackup  " only in case you don't want a backup file while editing
set noundofile     " no undo files


" aid ------------------------
set noeb
set vb
set vb t_vb=
set hls
set ic
set is
set noshowcmd
set hidden
set nowrap
set fileformat=unix
set backspace+=indent,eol,start
set formatoptions=
set whichwrap+=<,>,h,l
set autoread<
set viminfo='1000,<50,s10,h
set listchars=tab:»\ ,trail:-,nbsp:␣
set shortmess-=S
set laststatus=0
set background=dark
" set formatoptions-=r
set tags+="./TAGS"


" {{{ language config
autocmd FileType typescript,javascript,html,vue,vim call s:SetJsIndent()
autocmd FileType c,cpp,cxx call s:CXXEnvironment()
autocmd FileType java call s:JavaEnvironment()

function! s:JavaEnvironment()
  execute "setl path=**"
  execute "setl path+=~/java/**"
  execute "setl tags=./tags"
  execute "setl tags+=~/java/tags"
endfunction

function! s:SetJsIndent()
  execute "setl shiftwidth=2"
  execute "setl sts=2"
"   execute "setl ts=2"
  execute "setl autoindent"
  execute "setl expandtab"
endfunction

function! s:CXXEnvironment()
"  execute "setl shiftwidth=8"
"  execute "setl softtabstop=8"
  execute "setl tabstop=8"
"  execute "setl noexpandtab"
  execute "setl autoindent"
"  execute "setl cinkeys='0},0),0],:,0#,!^F,o,O,e'"
"  execute "setl path+=**"
"  execute "setl path+=/usr/local/include0/"
endfunction
" }}}

" {{{ command
command! Prettier :call PrettierWithFormat()
" }}}

" {{{ script
function! CompilCode()
  execute "w"
  if &filetype == 'c'
    call CompileRunGcc()
  elseif &filetype == 'vim'
    execute "source %"
  elseif &filetype == 'javascript'
    execute "!node %"
  elseif &filetype == 'rust'
    execute "!rustc % -o /tmp/cache/%:t:r"
    execute "!/tmp/cache/%:t:r"

  endif
endfunction

function! PrettierWithFormat()
  silent execute "%!prettier --stdin-filepath % --arrow-parens avoid --print-width 100 --single-quote --end-of-line auto"
endfunction

function! CompileRunGcc()
  if &filetype == 'c'
    silent execute("!mkdify /tmp/compileCache")
    silent execute "!gcc % -o /tmp/compileCache/%:t:r"
    echo execute("!/tmp/compileCache/%:t:r")
  endif
endfunction

function! EmptyFunc()

endfunction

function IsCocEnable()
  if (exists('g:coc_enable') && g:coc_enable)
    return 1
  else
    return 0
  endif
endfunction
" }}}

" {{{ plugin settings

" syntax
let g:syntastic_ignore_files = ['.zsh_history', '.bash_history', '.z']
let g:syntastic_enable_signs = 0
let g:syntastic_auto_loc_list = 1
let g:syntastic_loc_list_height = 6
let g:syntastic_c_checkers = ['make']

" session
let g:session_autoload = 'no'
let g:session_autosave = 'yes'
let g:session_lock_enabled = 0
let g:session_command_aliases = 1

" markdown
" let g:mkdp_browser = 'chromium'

" recognized filetypes
" these filetypes will have MarkdownPreview... commands
let g:mkdp_filetypes = ['markdown', 'md']
" }}}


" {{{ plugins
call plug#begin('~/.vim/plugged')

if !has('nvim')
  " syntax check
  Plug 'scrooloose/syntastic'
endif

" theme
Plug 'sickill/vim-monokai'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" session
Plug 'xolox/vim-session'
Plug 'xolox/vim-misc'

" nvim
if has('nvim')

  " tree
  Plug 'kyazdani42/nvim-web-devicons' " for file icons
  Plug 'kyazdani42/nvim-tree.lua'

  " Plug 'mrjones2014/dash.nvim', { 'do': 'make install' }

  if (exists('g:coc_enable') && g:coc_enable)
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
  endif

  " markdown
  " Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
  " If you have nodejs and yarn
  Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
else
  Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

endif

call plug#end()
" }}}

colo monokai
" hi PmenuSel ctermfg=white

" syntax off

"{{{ maps

" motion
inoremap <C-b> <left>
inoremap <C-f> <right>
inoremap <C-p> <Up>
inoremap <C-n> <Down>
nnoremap ' `

" command motion
cno <C-a> <home>
cnoremap <C-A> <Home>
cnoremap <Esc>b <S-Left>
cnoremap <Esc>f <S-Right>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-s> <C-f>

" edit
inoremap <C-e> <end>
inoremap <C-a> <home>
inoremap <C-d> <Delete>
nnoremap <silent> <F10> :call CompileCode()<cr>
inoremap <C-r>% <C-r>=expand("%:p")<cr>
inoremap <esc>f <c-o>w
inoremap <esc>b <c-o>b
inoremap <esc>d <c-o>de
tnoremap <C-q> <C-\><C-n>
nnoremap <leader>p :set paste!<CR>

" fzf
nnoremap <silent> <leader>f :Rg<cr>
nnoremap <silent> <expr> <C-n> (len(system('git rev-parse')) ? ':Files' : ':GFiles --exclude-standard --others --cached')."\<cr>"
" nnoremap <silent> <leader>f :Lines<cr>
nnoremap <silent> <leader>b :Buffers<cr>

" customize
nno <leader>t :r ~/template/
"}}} maps
