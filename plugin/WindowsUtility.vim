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
" Command
" ---------------------------------------------------------------------
command! TSRev call system('svn revert "' . expand('%:p') . '"')
command! TSDiff execute '!start TortoiseProc /command:diff /path:"' . expand('%:p') . '"'
command! TSLog execute '!start TortoiseProc /command:log /path:"' . expand('%:p') . '"'
command! TGRevert call system('git checkout "' . expand('%:p') . '"')
command! TGDiff execute '!start TortoiseGitProc /command:diff /path:"' . expand('%:p') . '"'
command! TGLog execute '!start TortoiseGitProc /command:log /path:"' . expand('%:p') . '"'
let &cpo = s:save_cpo
unlet s:save_cpo
