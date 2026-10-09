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
      \ '(eq? x y) (equal? x y) (eqv? x y)',
      \ '(term/with-kitty-keys (foo)',
      \ '(bar))',
      \ '(parameterize ((p 1))',
      \ '(foo))',
      \ '(list #t #f #true #false #truex)',
      \ '#| unsupported |#',
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
call assert_equal('semaOperator', synIDattr(synID(9, 2, 1), 'name'))
call assert_equal('semaOperator', synIDattr(synID(9, 12, 1), 'name'))
call assert_notequal('semaOperator', synIDattr(synID(9, 25, 1), 'name'))
call assert_equal('  (bar))', getline(11))
call assert_equal('  (foo))', getline(13))
for column in [7, 10, 13, 19]
  call assert_equal('semaBoolean', synIDattr(synID(14, column, 1), 'name'))
endfor
call assert_notequal('semaBoolean', synIDattr(synID(14, 26, 1), 'name'))
call assert_notequal('semaBlockComment', synIDattr(synID(15, 5, 1), 'name'))

if !empty(v:errors)
  for error in v:errors
    echom error
  endfor
  cquit
endif
quit!
