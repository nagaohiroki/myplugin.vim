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
command! TSRev call system('svn revert "' . expand('%') . '"')
command! TSDiff execute '!start TortoiseProc /command:diff /path:"' . expand('%') . '"'
command! TSLog execute '!start TortoiseProc /command:log /path:"' . expand('%') . '"'
command! TGRevert call system('git checkout "' . expand('%') . '"')
command! TGDiff execute '!start TortoiseGitProc /command:diff /path:"' . expand('%') . '"'
command! TGLog execute '!start TortoiseGitProc /command:log /path:"' . expand('%') . '"'
let &cpo = s:save_cpo
unlet s:save_cpo
