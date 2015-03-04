" ----------------------------------------------------------------------
" windows utility
" ---------------------------------------------------------------------
if has('win32')

	" svn
	command! SvnLog :silent! !TortoiseProc /command:log /path:%
	command! SvnDiff :silent! !TortoiseProc /command:diff /path:%
	command! SvnRevert :silent! !svn revert %

	" git
	command! GitLog :silent! !TortoiseGitProc /command:log /path:%
	command! GitDiff :silent! !TortoiseGitProc /command:diff /path:%
	command! GitRevert :silent! !git checkout %

	" oepn windows explorer
	command! Wex :silent! !explorer /select,%

	" path cut
	nnoremap <F3> $F/v0dj

endif
