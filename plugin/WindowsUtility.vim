" ----------------------------------------------------------------------
" windows utility
" ---------------------------------------------------------------------
" 
if !has('win32')
	finish
endif

" ----------------------------------------------------------------------
" function
" ---------------------------------------------------------------------
" VCType
function! GetVCType()

	let l:cdLocalPath = 'cd ' . expand('%:p:h') . ' & ' 

	" git
	let l:git = system(l:cdLocalPath . ' git rev-parse --show-toplevel')
	let l:notgit = 'Not a git repository'
 	if(stridx(l:git, l:notgit) == -1)
		return 'git'
	endif

	"svn
	let l:svn = system(l:cdLocalPath . ' svn info')
	let l:notsvn = 'is not a working copy'
 	if(stridx(l:svn, l:notsvn) == -1)
		return 'svn'
	endif

	return 'none'

endfunction

" WorkingPath
function! GetWorkingRootPath(vcType)

	" git
	if(a:vcType == 'git')
		let l:gitCommand = system('git rev-parse --show-toplevel')
		let l:gitWorkingPath = substitute(l:gitCommand, '\n', "", "g")
		return l:gitWorkingPath
	endif

	" svn
	if(a:vcType == 'svn')
		let l:svnCommand = system('git rev-parse --show-toplevel')
		let l:svnWorkingPath = substitute(l:svnCommand[24:-1], '\n', "", "g")
		return l:svnWorkingPath
	endif
	echo ' Not compatible VCS'
	return 'none'

endfunction

" TortoiseProc
function! VCProc(vcType, com, path)

	if(a:vcType == 'none')
		return
	endif

	if(a:vcType == 'git')
		let l:vcs = 'TortoiseGitProc'
	endif

	if(a:vcType == 'svn')
		let l:vcs = 'TortoiseProc'
	endif

	let l:cmd = l:vcs . ' /command:' . a:com . ' /path:"' . a:path . '"'
	echo system(l:cmd)
endfunction

" CurrentFile
function! VCProcLocal(com)
	let l:vcType = GetVCType()
	call VCProc(l:vcType, a:com, expand('%:p'))
endfunction

" RootDirectory
function! VCProcRoot(com)
	let l:vcType = GetVCType()
	let l:rootPath = GetWorkingRootPath(l:vcType)
	call VCProc(l:vcType, a:com, l:rootPath)
endfunction

" RevertCommmand
function! VCRevert(path)
	
	let l:vcType = GetVCType()

	if(l:vcType == 'none')
		return
	endif

	if(l:vcType == 'git')
		let l:command = ' checkout '
	endif

	if(l:vcType == 'svn')
		let l:command = ' revert '
	endif

	echo system( l:vcType . l:command . a:path)
endfunction

" ----------------------------------------------------------------------
" Command
" ---------------------------------------------------------------------

command! VCLog call VCProcLocal('log') 
command! VCDiff call VCProcLocal('diff') 
command! VCRevert call VCRevert(expand('%:p'))

command! VCRootRevert call VCProcRoot('revert')
command! VCRootLog    call VCProcRoot('log')
command! VCRootCommit call VCProcRoot('commit')

" oepn windows explorer
command! Wex echo system('explorer /select,' . expand('%'))

