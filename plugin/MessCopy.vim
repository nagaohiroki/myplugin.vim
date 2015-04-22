" ----------------------------------------------------------------------
" MessCopy
" ---------------------------------------------------------------------
" Copy to selection too.
function! s:messcopy()
    redir @+>
    silent messages
    redir END
    call setreg('*', getreg('+', 1), getregtype('+'))
endfunction
command! MessCopy call s:messcopy()
