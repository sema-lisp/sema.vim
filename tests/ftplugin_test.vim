set runtimepath^=.
filetype plugin indent on
syntax on

new
setfiletype sema
call setline(1, [
      \ '(guard (e (else nil))',
      \ '(foo))',
      \ '(with-open (x y)',
      \ '(foo))',
      \ 'foo%bar',
      \ '+2e3 1/2 3+4i +i #xFF #e#xFF 0x1F',
      \ 'bytes/length async/with-timeout path/canonicalize db/open workflow/mcp-handle',
      \ '(policy/without "test" 1)',
      \ ])
silent normal! gg=G
call assert_equal('  (foo))', getline(2))
call assert_equal('  (foo))', getline(4))

call cursor(5, 5)
call assert_equal('foo%bar', expand('<cword>'))
call assert_true(stridx(&l:iskeyword, '37') >= 0)
call assert_true(stridx(&l:iskeyword, '94') >= 0)

for column in [1, 6, 10, 15, 18, 23]
  call assert_equal('semaNumber', synIDattr(synID(6, column, 1), 'name'))
endfor
call assert_notequal('semaNumber', synIDattr(synID(6, 31, 1), 'name'))

for column in [1, 14, 33, 51, 59]
  call assert_equal('semaBuiltin', synIDattr(synID(7, column, 1), 'name'))
endfor
call assert_equal('semaSpecial', synIDattr(synID(1, 2, 1), 'name'))
call assert_equal('semaSpecial', synIDattr(synID(8, 2, 1), 'name'))

if !empty(v:errors)
  for error in v:errors
    echom error
  endfor
  cquit
endif
quit!
