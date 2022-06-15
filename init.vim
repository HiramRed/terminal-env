" color
hi NormalFloat ctermbg=red

" let g:loaded_python3_provider = 0
" let g:loaded_python_provider = 0
let g:python3_host_prog = '/usr/bin/python3'
let g:python_host_prog = '/usr/bin/python'
set pyxversion=3

" nvim init
set runtimepath^=~/.vim runtimepath+=/Applications/MacVim.app/Contents/Resources/vim/runtime
let &packpath = &runtimepath

" set insert mode cursor block
set guicursor=n-v-c-sm-i:block,ve:ver25,r-cr-o:hor20

let g:coc_enable = 1

" environment
let g:vim_json_conceal = 0
let g:vim_markdown_conceal = 0
" let g:coc_suggest_disable = 1

" shada
rsh! ~/.my.shada
set shada+=:10000

source ~/.vimrc

luafile ~/.config/nvim/lua/script.lua
nnoremap <silent> <leader>e :NvimTreeOpen<cr>

" call defx#custom#option('_', {
"             \ 'winwidth': 30,
"             \ 'split': 'vertical',
"             \ 'direction': 'topleft',
"             \ 'show_ignored_files': 0,
"             \ 'buffer_name': '',
"             \ 'toggle': 1,
"             \ 'resume': 1
"             \ })

" coc -----------------
if (IsCocEnable())
  " set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

  " Highlight the symbol and its references when holding the cursor.
  " autocmd CursorHold * silent call CocActionAsync('highlight')

  source ~/.config/nvim/cocmap.vim
endif

source ~/.config/nvim/autoload/filetype.vim

colo monokai

syntax on
