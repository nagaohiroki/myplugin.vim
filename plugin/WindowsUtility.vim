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
let g:widows_utility=0
" ----------------------------------------------------------------------
" Command
" ---------------------------------------------------------------------
command! TSRev call system('svn revert "' . expand('%:p') . '"')
command! TSDiff call system('TortoiseProc /command:diff /path:"' . expand('%:p') . '"')
command! TSLog call system('TortoiseProc /command:log /path:"' . expand('%:p') . '"')
command! TGRevert call system('git checkout "' . expand('%:p') . '"')
command! TGDiff call system('TortoiseGitProc /command:diff /path:"' . expand('%:p') . '"')
command! TGLog call system('TortoiseGitProc /command:log /path:"' . expand('%:p') . '"')
let &cpo = s:save_cpo
unlet s:save_cpo
