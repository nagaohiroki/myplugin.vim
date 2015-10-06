" ----------------------------------------------------------------------
" Astyle
" ---------------------------------------------------------------------
function! Astyle()
	let l:pos = getpos('.')
	%!AStyle -I -A1 -t -p -D -U -k3 -W3 -J -E -xp
	call setpos('.',pos)
endfunction
command! Astyle :call Astyle()
