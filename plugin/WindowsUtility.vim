" ----------------------------------------------------------------------
" windows utility
" ---------------------------------------------------------------------
if has('win32')

	" svn
	command! SvnLog :silent! !TortoiseProc /command:log /path:%
	command! SvnDiff :silent! !TortoiseProc /command:diff /path:%
	command! SvnRevert :silent! !svn revert %

	" oepn windows explorer
	command! Wex :silent! !explorer /select,%

	" path cut
	nnoremap <F3> $F/v0dj

endif
