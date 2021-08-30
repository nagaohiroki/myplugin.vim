" ----------------------------------------------------------------------
" windows utility
" ---------------------------------------------------------------------
let s:save_cpo = &cpo
set cpo&vim
if !has('win32')
	finish
endif
if exists("g:widows_utility")
  finish
endif
" ----------------------------------------------------------------------
" Function
" ---------------------------------------------------------------------
function! FindRoot(targetpath)
	let dirname = fnamemodify(a:targetpath, ':h')
	let path = glob(dirname . '/.svn')
	if path != ''
		return dirname
	endif
	if dirname != a:targetpath
		return FindRoot(dirname)
	endif
	return ''
endfunction
" ----------------------------------------------------------------------
" Command
" ---------------------------------------------------------------------
command! TSRev call system('svn revert "' . expand('%:p') . '"')
command! TSDiff execute '!start TortoiseProc /command:diff /path:"' . expand('%:p') . '"'
command! TSLog execute '!start TortoiseProc /command:log /path:"' . expand('%:p') . '"'
command! TSCommit execute '!start TortoiseProc /command:commit /path:"' . FindRoot(expand('%:p:h')) . '"'
command! TGDiff execute '!start TortoiseGitProc /command:diff /path:"' . expand('%:p') . '"'
command! TGLog execute '!start TortoiseGitProc /command:log /path:"' . expand('%:p') . '"'
let &cpo = s:save_cpo
unlet s:save_cpo
