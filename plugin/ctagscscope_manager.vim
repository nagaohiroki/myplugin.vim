scriptencoding utf-8
 
" @brief
" ctagsとcscopeを.svn .gitと同じ階層に生成、破棄をするプラグイン
"
" @note
" gitかsvnがインストールされている場合のみ機能する
" .git,.svn両方がある場合svnが優先される
" windows環境のみで確認

let g:myplugin_path=expand('<sfile>:p:h')
" ----------------------------------------------------------------------
" project root path
" ---------------------------------------------------------------------
function! GetWorkingPath()
	if has('python')
		" project root path python ver
		execute 'pyf ' . g:myplugin_path . '/working_path.py'
		let g:working_path=py_working_path
	else
		let l:git_root_path=substitute(system('git rev-parse --show-toplevel'),'\n',"","g")
		let l:svn_root_path=substitute(system('svn info | grep ''Working''')[24:-1],'\n',"","g")

		if stridx(s:git_root_path, 'fatal: Not a') == -1
			let g:working_path=l:git_root_path
		endif

		if s:svn_root_path != ''
			let g:working_path=l:svn_root_path
		endif
	endif
endfunction
" ----------------------------------------------------------------------
" ctags
" ---------------------------------------------------------------------
call GetWorkingPath()
execute 'set tags+=' . g:working_path . '/.tags'
function! CtagsEditor( opt )

	call GetWorkingPath()
	if g:working_path == ''
		echo '作業フォルダ内のファイルではありません g:working_path = ' . g:working_path
	else
		if a:opt == 0
			silent! execute '!cd ' . g:working_path . ' & ctags -R -f .tags'
			execute 'set tags+=' . g:working_path . '/.tags'
		elseif a:opt == 1
			silent! execute '!rm ' . g:working_path . '/.tags'
		endif
	endif
endfunction

command! CtagsGenerate   : call CtagsEditor( 0 )
command! CtagsDelete     : call CtagsEditor( 1 )
" ----------------------------------------------------------------------
" cscope
" ---------------------------------------------------------------------
if has('cscope')
	set cscopequickfix=s-,c-,d-,i-,t-,e-
	nnoremap <C-}> :cs find d <C-R><C-W><CR>:cwin<CR>
	cs add g:working_path/cscope.out g:working_path

	function! CscopeEditor( opt )
		if a:opt == 0
			silent! execute '!cd ' . g:working_path . ' & cscope -R -b'
			execute 'cs add ' . g:working_path . '/cscope.out ' . g:working_path
		elseif a:opt == 1
			execute 'cs kill 0'
			silent! execute '!rm ' . g:working_path . '/cscope.out'
		endif
	endfunction
	command! CscopeGenerate  : call CscopeEditor( 0 )
	command! CscopeDelete    : call CscopeEditor( 1 )
endif

