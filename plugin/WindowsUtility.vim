" ----------------------------------------------------------------------
" windows utility
" ---------------------------------------------------------------------
" 
if !has('win32') || exists('g:WinUtil_loaded')
	finish
endif

" Global
let g:WinUtil_loaded = 1

" TortoiseProc
function! VCProc(com, path)

	let l:vcs = 'TortoiseProc'
	if(g:vc_type == 'git')
		let l:vcs = 'TortoiseGitProc'
	endif

	echo system(l:vcs . ' /command:' . a:com . ' /path:"' . a:path . '"')
endfunction

" RevertCommmand
function! VCRevert(path)
	let l:vcs = 'svn revert '
	if(g:vc_type == 'git')
		let l:vcs = 'git checkout '
	endif
	echo system(l:vcs . a:path)
endfunction

" Command
command! VCLog call VCProc('log', expand('%:p')) 
command! VCDiff call VCProc('diff', expand('%:p')) 
command! VCRevert call VCRevert( expand('%:p'))

command! VCRootRevert call VCProc( 'revert', g:cv_root )
command! VCRootLog    call VCProc( 'log', g:vc_root )
command! VCRootCommit call VCProc( 'commit', g:vc_root )

" oepn windows explorer
command! Wex :silent! echo system('explorer /select,' . expand('%'))


