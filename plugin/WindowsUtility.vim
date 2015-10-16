" ----------------------------------------------------------------------
" windows utility
" ---------------------------------------------------------------------
if !has('win32') || exists('g:WinUtil_loaded')
	finish
endif
let g:WinUtil_loaded = 1

function! SvnProc(com, path)
	echo system('TortoiseProc /command:' . a:com . ' /path:' . a:path)
endfunction
" svn

command! SvnLog call SvnProc('log', expand('%:p')) 
command! SvnDiff call SvnProc('diff', expand('%:p')) 
command! SvnRevert echo system('svn revert ' . expand('%'))

" git
command! GitLog :silent! !TortoiseGitProc /command:log /path:%
command! GitDiff :silent! !TortoiseGitProc /command:diff /path:%
command! GitRevert :silent! !git checkout %

" oepn windows explorer
command! Wex :silent! echo system('explorer /select,' . expand('%'))


