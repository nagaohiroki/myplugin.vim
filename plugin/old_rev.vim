if exists('g:old_rev')
  finish
endif
let g:old_rev=1

let s:save_cpo = &cpo
set cpo&vim
let s:py_path = join([expand('<sfile>:p:h:h'), 'python'], '/')
function! OldRev()
	if(&diff == 1)
		diffoff!
		return
	endif
	CdCurrent
	exec "python sys.path.append(r'" . s:py_path . "')"
	exec 'pyfile ' . fnameescape(s:py_path . '/old_rev.py')
endfunction
command! OldRev call OldRev()

let &cpo = s:save_cpo
unlet s:save_cpo
