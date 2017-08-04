" --------------------------------------------------------------------
" Perforce Plugins
"
" windows example
" set P4CLIENT=UE4PROJ
" set P4DIFF=C:\Program Files\WinMerge\WinMergeU.exe
" set P4PASSWD=**
" --------------------------------------------------------------------
if exists("g:perforce_vim")
  finish
endif
let g:perforce_vim=1
let s:save_cpo = &cpo
set cpo&vim
let s:win_start=has('win32') ? 'start /min ' : ''
command! P4edit cd %:h | call system('p4 edit "' . fnameescape(expand('%')) . '"')
command! P4revert cd %:h | call system('p4 revert -c default "' . fnameescape(expand('%')) . '"')
command! P4diff cd %:h | call system(s:win_start . 'p4 diff "' . fnameescape(expand('%')) . '"')
command! P4pending cd %:h | echo system('p4 opened')
command! P4cleanup cd %:h | call system('p4 revert -a -c default') | echo system('p4 opened')
let &cpo = s:save_cpo
unlet s:save_cpo
