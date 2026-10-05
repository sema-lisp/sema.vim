if exists('b:did_ftplugin')
  finish
endif
let b:did_ftplugin = 1

setlocal commentstring=;\ %s
setlocal comments=:;
setlocal lisp
setlocal lispwords=define,def,defun,defn,lambda,fn,if,cond,case,when,unless
setlocal lispwords+=let,let*,letrec,begin,progn,do,while
setlocal lispwords+=let-values,let*-values,define-values,define-syntax
setlocal lispwords+=match,match*,defmulti,defmethod,async,await
setlocal lispwords+=define-record-type,defmacro,defagent,deftool
setlocal lispwords+=defworkflow,defpolicy,policy/without
setlocal lispwords+=try,catch
setlocal lispwords+=module
setlocal lispwords+=set!,throw,import,load,delay,force
setlocal lispwords+=prompt,message
setlocal lispwords+=guard,when-let,if-let,with-stream,with-open,with-retry
setlocal lispwords+=with-span,with-session,llm/with-budget
setlocal lispwords+=io/with-raw-mode,term/with-alt-screen,term/with-mouse
setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal expandtab
setlocal iskeyword+=33,63,47,45,62,42,60,35,43,61,38,37,94,126,46

let b:undo_ftplugin = 'setlocal commentstring< comments< lisp< lispwords<'
      \ . ' tabstop< shiftwidth< softtabstop< expandtab< iskeyword<'
