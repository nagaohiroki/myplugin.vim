
if exists("loaded_cscommenter")
  finish
endif
let loaded_cscommenter=1

function! <SID>CS_Comment()
  let l:a_back = @a
  let l:c_back = @c
  let b:i = 1
  let b:old_ve = &virtualedit
  " set virtual edit so we end up in the right place when we tab.
  set virtualedit=all

  " see if we're on a line with a /// comment already
  let l:oncomment = match(getline('.'), "[ \t]*///") != -1

  " go to first noncomment line
  if (l:oncomment)
    exe "normal! /^\\([ \t]*\\/\\/\\/\\)\\@!\<cr>"
    let l:hadcomment = 1
  else
    " see if there is a comment above this line
    let l:hadcomment = match(getline(line('.') - 1), "[ \t]*///") != -1
  endif

  if (l:hadcomment)
    let l:lastcomment = line('.') - 1
    normal! k0

    " goto first comment line
    exe "normal! ?^\\([ \t]*\\/\\/\\/\\)\\@!?1\<cr>"
    let l:firstcomment = line('.')

    " delete the comment into reg c
    exe l:firstcomment . "," . l:lastcomment . "d c"
  endif

  " yank from beg of line to the end of the function header into reg a
  exe "normal! 0\"ay/{\\|;\<cr>"

  " get the return type, or access modifier if its a constructor
  let l:rt = matchstr(@a, "\\h\\w*\\ze[ \t\n]\\+\\h\\w*[ \t\n]*([^)]*)")

  let l:isprop = match(@a, "\\%(\\<class\\>\\|\\<interface\\>\\|(\\_.*)\\)") == -1

  " get the params
  let l:params = matchstr(@a, "\\h\\w*[ \t\n]*([ \t\n]*\\zs[^)]*\\ze[ \t\n]*)")

  " insert summary info
  exe "normal! O/// \<esc>maa<summary>"

  " if we have a comment and a summary
  if (l:hadcomment)
    set paste
    exe "normal! a" . matchstr(@c, "<summary>\\zs\\_.\\{-}\\(\n[ \t]*///[ \t]*\\)\\?\\ze</summary>")
    set nopaste
  endif

  exe "normal! a</summary>"

  " if this is a property, add value, otherwise add params and returns
  if (l:isprop)
    " insert value info
    exe "normal! o/// \<esc>mca<value>"

    " if we have a comment and a value
    if (l:hadcomment)
      set paste
      exe "normal! a" . matchstr(@c, "<value>\\zs\\_.\\{-}\\(\n[ \t]*///[ \t]*\\)\\?\\ze</value>")
      set nopaste
    endif

    exe "normal! a</value>"
    let b:i = b:i + 1
  else
    " go through the params and add their tags
    while strlen(l:params) > 0
      let b:i = b:i + 1
      let l:m = nr2char(b:i + 97)

      let l:param = matchstr(l:params, "\\(ref \\)\\=\\h\\w*[ \t\n]\\+\\zs\\h\\w*")
      exe "normal! o/// \<esc>m" . l:m . "a<param name=\"" . l:param . "\">"

      if (l:hadcomment)
        set paste
        exe "normal! a" . matchstr(@c, "<param name=\"" . l:param . "\">\\zs\\_.\\{-}\\ze</param>")
        set nopaste
      endif

      exe "normal! a</param>"

      let l:params = matchstr(l:params, ",\\zs[^)]*")
    endwhile

    " if we return something, add the returns tag
    if (strlen(l:rt) > 0 && l:rt != "void" && l:rt != "public" && l:rt != "private" && l:rt != "protected")
      let b:i = b:i + 1
      let l:m = nr2char(b:i + 97)
      exe "normal! o/// \<esc>m" . l:m . "a<returns>"
      if (l:hadcomment)
        set paste
        exe "normal! a" . matchstr(@c, "<returns>\\zs\\_.\\{-}\\ze\\(\n[ \t]*///[ \t]*\\)\\?</returns>")
        set nopaste
      endif
      exe "normal! a</returns>"
    endif
  endif

  " go back to the summary.
  normal! `a
  exec "normal! h/<\\(.*\\)>\\_.\\{-}\\zs\\ze\\(\\n[ \t]*\\/\\/\\/[ \t]*\\)\\=<\\/\\1>\<cr>"

  " remember what the last mark was
  let b:n = b:i
  let b:i = 0

  " restore the registers
  let @a = l:a_back
  let @c = l:c_back

  let &virtualedit = b:old_ve

  startinsert
endfunction

command! Cscomment :silent! call <SID>CS_Comment()<cr>
