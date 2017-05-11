" --------------------------------------------------------------------
" Perforce Plugins
"
" windows example
" set P4CLIENT=UE4PROJ
" set P4DIFF=C:\Program Files\WinMerge\WinMergeU.exe
" --------------------------------------------------------------------
if exists("g:perforce_vim")
  finish
endif
let g:perforce_vim=1
let s:save_cpo = &cpo
set cpo&vim
command! P4Edit call system('p4 edit "' . fnameescape(expand('%')) . '"')
command! P4Revert call system('p4 revert -c default "' . fnameescape(expand('%')) . '"')
command! P4Diff call system('p4 diff "' . fnameescape(expand('%')) . '"')
let &cpo = s:save_cpo
unlet s:save_cpo
