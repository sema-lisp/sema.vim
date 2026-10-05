set nocompatible
set runtimepath^=.
syntax on

new
setfiletype sema
call setline(1, '(regex/match? #"\d+" "123")')
call setline(2, '(regex/match? #"\"[^\"]+\"" text)')
call setline(3, '(regex/match? #"\\" text)')

function! AssertGroup(line, column, expected) abort
  let actual = synIDattr(synID(a:line, a:column, 1), 'name')
  if actual !=# a:expected
    echom printf('%d:%d expected %s, got %s', a:line, a:column, a:expected, actual)
    cquit 1
  endif
endfunction

call AssertGroup(1, 2, 'semaBuiltin')
call AssertGroup(1, 15, 'semaRegex')
call AssertGroup(1, 17, 'semaRegex')
call AssertGroup(2, 15, 'semaRegex')
call AssertGroup(2, 18, 'semaRegex')
call AssertGroup(3, 15, 'semaRegex')
call AssertGroup(3, 17, 'semaRegex')

quitall!
