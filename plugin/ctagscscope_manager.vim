scriptencoding utf-8

if exists( 'g:local_working_path' )
	execute 'set tags=' . g:local_working_path . '/tags'

	" Ctags
	function! CtagsEditor( opt, work_path )
		if a:opt == 0
			silent! execute '!cd ' . a:work_path . ' & ctags -R'
			execute 'set tags=' . a:work_path . '/tags'
		elseif a:opt == 1
			silent! execute '!rm ' . a:work_path . '/tags'
		endif
	endfunction


	command! CtagsGenerate   : call CtagsEditor( 0, g:local_working_path )
	command! CtagsDelete     : call CtagsEditor( 1, g:local_working_path )

	" Cscope
	if has('cscope')
		set cscopequickfix=s-,c-,d-,i-,t-,e-
		nnoremap <C-}> :cs find d <C-R><C-W><CR>:cwin<CR>
		cs add g:local_working_path/cscope.out g:local_working_path


		function! CscopeEditor( opt, work_path )
			if a:opt == 0
				silent! execute '!cd ' . a:work_path . ' & cscope -R -b'
				execute 'cs add ' . a:work_path . '/cscope.out ' . a:work_path
			elseif a:opt == 1
				execute 'cs kill 0'
				silent! execute '!rm ' . a:work_path . '/cscope.out'
			endif
		endfunction
		command! CscopeGenerate  : call CscopeEditor( 0, g:local_working_path )
		command! CscopeDelete    : call CscopeEditor( 1, g:local_working_path )
	endif
endif
