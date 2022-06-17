let mapleader = "\<space>"
let loaded_matchparen=1       " do no highlight matched pairs

setl foldmethod=marker

if !has('nvim')
  language en_US
endif

" netrw
let g:netrw_banner=0	    " diable banner

" vim gui
let macvim_skip_colorscheme=1
" set guifont=Comic\ Mono:h21
set guicursor=n-v-c-sm-i:block-blinkon0,ve:ver25,r-cr-o:hor20


set path=.
set path+=**
set wildignore+=*node_modules/*


" main ------------------------------
set autoindent
set noexpandtab
set shiftwidth=4
set softtabstop=4


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

" {{{ language config
autocmd FileType typescript,javascript,html,vim call s:SetJsIndent()
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
  execute "setl softtabstop=2"
  execute "setl expandtab"
  execute "setl autoindent"
endfunction

function! s:CXXEnvironment()
  execute "setl shiftwidth=2"
  execute "setl softtabstop=2"
  execute "setl noautoindent"
  execute "setl noexpandtab"
  execute "setl cindent"
"  execute "setl cinkeys='0},0),0],:,0#,!^F,o,O,e'"
"   execute "setl path+=**"
"   execute "setl path+=/usr/local/include/"
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

" colo monokai
hi PmenuSel ctermfg=white

syntax off

"{{{ maps

" motion
inoremap <C-b> <left>
inoremap <C-f> <right>
nnoremap ' `

" command motion
cno <C-a> <home>
cnoremap <C-A> <Home>
cnoremap <Esc>b <S-Left>
cnoremap <Esc>f <S-Right>

" edit
inoremap <C-e> <end>
inoremap <C-a> <home>
inoremap <C-d> <Delete>
nnoremap <silent> <F10> :call CompilCode()<cr>
inoremap <C-r>% <C-r>=expand("%:p")<cr>
tnoremap <C-q> <C-\><C-n>

" fzf
nnoremap <silent> <leader>F :Rg<cr>
nnoremap <silent> <expr> <C-n> (len(system('git rev-parse')) ? ':Files' : ':GFiles --exclude-standard --others --cached')."\<cr>"
nnoremap <silent> <leader>f :Lines<cr>
nnoremap <silent> <leader>b :Buffers<cr>

"}}} maps
