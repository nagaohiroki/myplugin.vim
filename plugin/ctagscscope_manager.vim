scriptencoding utf-8

if exists('g:not_used_ctagscscope'	)
	if g:not_used_ctagscscope ==1
		finish
	endif
endif

if exists( 'g:local_working_path' )
	execute 'set tags=' . g:local_working_path . '/tags'

	" Ctags
	function! CtagsEditor( opt )
		if a:opt == 0
			silent! execute '!cd ' . g:local_working_path . ' & ctags -R'
			execute 'set tags=' . g:local_working_path . '/tags'
		elseif a:opt == 1
			silent! execute '!rm ' . g:local_working_path . '/tags'
		endif
	endfunction
	command! CtagsGenerate   : call CtagsEditor( 0 )
	command! CtagsDelete     : call CtagsEditor( 1 )

	" Cscope
	if has('cscope')
		set cscopequickfix=s-,c-,d-,i-,t-,e-
		nnoremap <C-}> :cs find d <C-R><C-W><CR>:cwin<CR>
		cs add g:local_working_path/cscope.out g:local_working_path
		function! CscopeEditor( opt )
			if a:opt == 0
				silent! execute '!cd ' . g:local_working_path . ' & cscope -R -b'
				execute 'cs add ' . g:local_working_path . '/cscope.out ' . g:local_working_path
			elseif a:opt == 1
				execute 'cs kill 0'
				silent! execute '!rm ' . g:local_working_path . '/cscope.out'
			endif
		endfunction
		command! CscopeGenerate  : call CscopeEditor( 0 )
		command! CscopeDelete    : call CscopeEditor( 1 )
	endif
endif
