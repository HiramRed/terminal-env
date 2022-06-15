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
"   execute "setl noautoindent"
  execute "setl noexpandtab"
  execute "setl cindent"
  execute "setl cinkeys='0},0),0],:,0#,!^F,o,O,e'"
"   execute "setl path+=**"
"   execute "setl path+=/usr/local/include/"
endfunction

" autocmd FileType java setl smartindent

" autocmd FileType c setl cindent
