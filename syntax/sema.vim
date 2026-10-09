if exists('b:current_syntax')
  finish
endif

scriptencoding utf-8

setlocal iskeyword+=33,63,47,45,62,42,60,35,43,61,38,37,94,126,46

" ---------- Parens / Brackets -------------------------------------------

syn match semaParens /[(){}\[\]]/

" ---------- Comments ----------------------------------------------------

syn match semaComment /;.*$/ contains=semaTodo
syn keyword semaTodo TODO FIXME XXX HACK NOTE contained

" ---------- Strings & Characters ----------------------------------------

syn region semaRegex start=/#"/ skip=/\\./ end=/"/
syn region semaString start=/"/ skip=/\\./ end=/"/ contains=semaStringEscape
syn match semaStringEscape /\\./ contained

" ---------- Numbers -----------------------------------------------------

syn match semaNumber /\v%(^|[[:space:](\[{])\zs[+-]?[0-9]+%(\/[0-9]+|%(\.[0-9]+)?%([eE][+-]?[0-9]+)?)%([+-]%([0-9]+%(\/[0-9]+|%(\.[0-9]+)?%([eE][+-]?[0-9]+)?))?i|i)?\ze%($|[[:space:])\]}])/
syn match semaNumber /\v%(^|[[:space:](\[{])\zs[+-]i\ze%($|[[:space:])\]}])/
syn match semaNumber /\v%(^|[[:space:](\[{])\zs%(#[eEiI]#[dD]|#[dD]#[eEiI]|#[eEiIdD])%([+-]?[0-9]+%(\/[0-9]+|%(\.[0-9]+)?%([eE][+-]?[0-9]+)?)%([+-]%([0-9]+%(\/[0-9]+|%(\.[0-9]+)?%([eE][+-]?[0-9]+)?))?i|i)?|[+-]i)\ze%($|[[:space:])\]}])/
syn match semaNumber /\v%(^|[[:space:](\[{])\zs%(#[eEiI]#[xX]|#[xX]#[eEiI]|#[xX])[+-]?[0-9a-fA-F]+\ze%($|[[:space:])\]}])/
syn match semaNumber /\v%(^|[[:space:](\[{])\zs%(#[eEiI]#[oO]|#[oO]#[eEiI]|#[oO])[+-]?[0-7]+\ze%($|[[:space:])\]}])/
syn match semaNumber /\v%(^|[[:space:](\[{])\zs%(#[eEiI]#[bB]|#[bB]#[eEiI]|#[bB])[+-]?[01]+\ze%($|[[:space:])\]}])/

" ---------- Booleans & Constants ----------------------------------------

syn keyword semaBoolean #t #f #true #false true false
syn keyword semaConstant nil

" ---------- Character Literals ------------------------------------------

syn match semaCharacter /\v#\\%(space|newline|tab|return|nul|alarm|backspace|delete|escape)/
syn match semaCharacter /\v#\\./

" ---------- Keywords (colon-prefixed) -----------------------------------

syn match semaKeyword /\v:[a-zA-Z0-9_/!?\-><*]+/

" ---------- Special Forms -----------------------------------------------

syn keyword semaSpecial define def defun defn lambda fn if cond case when unless
syn keyword semaSpecial term/with-bracketed-paste term/with-focus-events term/with-kitty-keys
syn keyword semaSpecial parameterize dotimes for-range
syn keyword semaSpecial let let* letrec begin progn do while and or
syn keyword semaSpecial let-values let*-values define-values define-syntax
syn keyword semaSpecial match match* defmulti defmethod async await
syn keyword semaSpecial set! quote quasiquote unquote unquote-splicing
syn keyword semaSpecial define-record-type defmacro defagent deftool defworkflow defpolicy
syn keyword semaSpecial try catch throw
syn keyword semaSpecial import module export load
syn keyword semaSpecial delay force eval macroexpand else
syn keyword semaSpecial guard when-let if-let with-stream with-open with-retry policy/without
syn keyword semaSpecial with-span with-session llm/with-budget
syn keyword semaSpecial io/with-raw-mode term/with-alt-screen term/with-mouse
syn keyword semaSpecial prompt message

" ---------- Definition Names --------------------------------------------

" (define name ...) — simple variable
syn match semaDefineVar /\v\(%(define|def)\s+\zs[a-zA-Z!$%&*+\-./:<=>?@^~_][a-zA-Z0-9!$%&*+\-./:<=>?@^~_]*\ze[^(]/

" (define (name ...) ...) — function definition
syn match semaDefineFun /\v\(%(define|def)\s+\(\zs[a-zA-Z!$%&*+\-./:<=>?@^~_][a-zA-Z0-9!$%&*+\-./:<=>?@^~_]*/

" Named definition forms
syn match semaDefineFun /\v\(%(defun|defn|defmacro|defmulti|defmethod|defagent|deftool|defworkflow|defpolicy)\s+\zs[a-zA-Z!$%&*+\-./:<=>?@^~_][a-zA-Z0-9!$%&*+\-./:<=>?@^~_]*/

" (set! name value)
syn match semaSetTarget /\v\(set!\s+\zs[a-zA-Z!$%&*+\-./:<=>?@^~_][a-zA-Z0-9!$%&*+\-./:<=>?@^~_]*/

" ---------- Threading Macros --------------------------------------------

syn match semaThreading /\v%(^|[( \t])\zs(-\>|-\>\>|as-\>)\ze%([) \t\n]|$)/

" ---------- Operators ---------------------------------------------------

syn match semaOperator /\v%(^|[( \t\[{])\zs[+\-*/]\ze%([) \t\]}\n]|$)/
syn match semaOperator /\v%(^|[( \t\[{])\zs[<>=]\ze%([) \t\]}\n]|$)/
syn match semaOperator /\v%(^|[( \t\[{])\zs[<>]\=\ze%([) \t\]}\n]|$)/
syn keyword semaOperator eq? equal?

" ---------- Builtin Functions -------------------------------------------
" Generated from crates/sema-docs/builtin_docs.generated.json.

syn keyword semaBuiltin & *stderr* *stdin* *stdout* abs agent agent/max-turns
syn keyword semaBuiltin agent/model agent/name agent/run agent/system agent/tools agent? angle
syn keyword semaBuiltin any any? append apply approval assert assert=
syn keyword semaBuiltin assoc assoc-in assq assv async/all async/await async/cancel
syn keyword semaBuiltin async/cancelled? async/forced? async/map async/pending? async/pool-map async/promise? async/race
syn keyword semaBuiltin async/race-owned async/rejected async/rejected? async/resolved async/resolved? async/run async/sleep
syn keyword semaBuiltin async/spawn async/spawn-all async/timeout async/with-timeout base64/decode base64/decode-bytes base64/encode
syn keyword semaBuiltin base64/encode-bytes bit/and bit/not bit/or bit/shift-left bit/shift-right bit/xor
syn keyword semaBuiltin bool? boolean? bytes/->string bytes/find bytes/length bytes/parse-int10 bytes/ref
syn keyword semaBuiltin bytes/slice bytevector bytevector->list bytevector-append bytevector-copy bytevector-length bytevector-u8-ref
syn keyword semaBuiltin bytevector-u8-set! bytevector/append bytevector/copy bytevector/from-list bytevector/length bytevector/make bytevector/new
syn keyword semaBuiltin bytevector/ref bytevector/set! bytevector/to-list bytevector/u8-ref bytevector/u8-set! bytevector? caaar
syn keyword semaBuiltin caadr caar cadar cadr call-with-values car cdaar
syn keyword semaBuiltin cdadr cdar cddar cdddr cddr cdr ceil
syn keyword semaBuiltin ceiling channel/close channel/closed? channel/count channel/empty? channel/full? channel/new
syn keyword semaBuiltin channel/recv channel/send channel/try-recv channel? char-ci<=? char-ci<? char-ci=?
syn keyword semaBuiltin char-ci>=? char-ci>? char-lower-case? char/alphabetic? char/downcase char/numeric? char/to-integer
syn keyword semaBuiltin char/to-string char/upcase char/upper-case? char/whitespace? char<=? char<? char=?
syn keyword semaBuiltin char>=? char>? char? checkpoint complex? cons contains?
syn keyword semaBuiltin context/all context/clear context/get context/get-hidden context/has-hidden? context/has? context/merge
syn keyword semaBuiltin context/pop context/pull context/push context/remove context/set context/set-hidden context/stack
syn keyword semaBuiltin context/with conversation/add-message conversation/cost conversation/filter conversation/find conversation/fork conversation/insert
syn keyword semaBuiltin conversation/last-reply conversation/length conversation/map conversation/map-role conversation/messages conversation/model conversation/models-used
syn keyword semaBuiltin conversation/new conversation/remove conversation/replace conversation/say conversation/say-as conversation/search conversation/set-system
syn keyword semaBuiltin conversation/stats conversation/system conversation/token-count conversation/turns conversation? cos count
syn keyword semaBuiltin csv/encode csv/parse csv/parse-maps db/close db/exec db/exec-batch db/last-insert-id
syn keyword semaBuiltin db/open db/open-memory db/query db/query-one db/tables deep-merge denominator
syn keyword semaBuiltin diff/apply diff/hunks diff/parse diff/stat diff/unified display dissoc
syn keyword semaBuiltin document/chunk document/create document/metadata document/text dotimes drop drop-while
syn keyword semaBuiltin e embedding/->list embedding/length embedding/list->embedding embedding/ref empty? enumerate
syn keyword semaBuiltin env error even? event/select every every? exact
syn keyword semaBuiltin exact->inexact exact-integer-sqrt exact-integer? exact? exit expt f64-array
syn keyword semaBuiltin f64-array/dot f64-array/fold f64-array/from-list f64-array/length f64-array/make f64-array/map f64-array/range
syn keyword semaBuiltin f64-array/ref f64-array/set! f64-array/sum f64-array? file/append file/copy file/delete
syn keyword semaBuiltin file/exists? file/fold-lines file/fold-lines-bytes file/for-each-line file/glob file/info file/is-directory?
syn keyword semaBuiltin file/is-file? file/is-symlink? file/list file/mkdir file/read file/read-bytes file/read-lines
syn keyword semaBuiltin file/rename file/write file/write-bytes file/write-lines filter first flat-map
syn keyword semaBuiltin flatten flatten-deep float float? floor fn? fold
syn keyword semaBuiltin foldl foldr for for-each for-range format format/form
syn keyword semaBuiltin frequencies fs/unwatch fs/watch fs/watch-events gc/collect gc/stats gcd
syn keyword semaBuiltin gensym get get-in git/changed-files git/current-branch git/diff git/diff-files
syn keyword semaBuiltin git/ignore-matches? git/recent-files git/root git/status gzip/compress gzip/decompress hash-map
syn keyword semaBuiltin hash-map? hash-ref hash/digest hash/hmac-sha256 hash/md5 hash/sha256 hashmap/assoc
syn keyword semaBuiltin hashmap/contains? hashmap/get hashmap/keys hashmap/new hashmap/to-map html/parse html/select
syn keyword semaBuiltin html/select-text html/text http/created http/delete http/error http/file http/get
syn keyword semaBuiltin http/html http/no-content http/not-found http/ok http/post http/put http/query
syn keyword semaBuiltin http/redirect http/request http/router http/serve http/stream http/text http/websocket
syn keyword semaBuiltin i64-array i64-array/from-list i64-array/make i64-array/range imag-part inexact inexact->exact
syn keyword semaBuiltin inexact? int integer/to-char integer? interpose io/eof? io/flush
syn keyword semaBuiltin io/print-error io/println-error io/read-key io/read-key-timeout io/read-line io/read-many io/read-stdin
syn keyword semaBuiltin io/tty-raw! io/tty-restore! iota json/decode json/encode json/encode-pretty keys
syn keyword semaBuiltin keyword/to-string keyword? kv/close kv/delete kv/get kv/keys kv/open
syn keyword semaBuiltin kv/set last lcm length list list->bytevector list->string
syn keyword semaBuiltin list->vector list/avg list/chunk list/contains? list/cross-join list/dedupe list/diff
syn keyword semaBuiltin list/drop-last list/drop-while list/duplicates list/find list/group-by list/index-of list/interleave
syn keyword semaBuiltin list/intersect list/join list/key-by list/max list/median list/min list/mode
syn keyword semaBuiltin list/nth-or list/pad list/page list/pick list/pluck list/reject list/repeat
syn keyword semaBuiltin list/shuffle list/sliding list/sole list/split-at list/sum list/take-last list/take-while
syn keyword semaBuiltin list/times list/to-bytevector list/unique list? llm/auto-configure llm/batch llm/budget-remaining
syn keyword semaBuiltin llm/cache-clear llm/cache-key llm/cache-stats llm/cassette-eject llm/cassette-load llm/cassette-save llm/chat
syn keyword semaBuiltin llm/classify llm/clear-budget llm/compare llm/complete llm/configure llm/configure-embeddings llm/current-provider
syn keyword semaBuiltin llm/default-provider llm/define-provider llm/embed llm/extract llm/extract-from-image llm/last-usage llm/list-providers
syn keyword semaBuiltin llm/pmap llm/pricing-status llm/providers llm/rerank llm/reset-usage llm/send llm/session-usage
syn keyword semaBuiltin llm/set-budget llm/set-default llm/set-pricing llm/similarity llm/stream llm/summarize llm/token-count
syn keyword semaBuiltin llm/token-estimate llm/with-cache llm/with-cassette llm/with-fallback llm/with-rate-limit log log/debug
syn keyword semaBuiltin log/error log/info log/warn magnitude make-bytevector make-list make-parameter
syn keyword semaBuiltin make-polar make-rectangular make-string map map-indexed map/assoc-in map/deep-merge
syn keyword semaBuiltin map/entries map/except map/filter map/from-entries map/get-in map/map-keys map/map-vals
syn keyword semaBuiltin map/new map/select-keys map/sort-keys map/update map/update-in map/zip map?
syn keyword semaBuiltin mapcar markdown/frontmatter markdown/headings markdown/to-html math/acos math/asin math/atan
syn keyword semaBuiltin math/atan2 math/clamp math/cosh math/degrees->radians math/exp math/format-fixed math/gcd
syn keyword semaBuiltin math/infinite? math/infinity math/lcm math/lerp math/log10 math/log2 math/map-range
syn keyword semaBuiltin math/nan math/nan? math/pow math/quotient math/radians->degrees math/random math/random-int
syn keyword semaBuiltin math/remainder math/round-to math/sign math/sinh math/tan math/tanh max
syn keyword semaBuiltin mcp/call mcp/close mcp/connect mcp/tools mcp/tools->sema member memory/append
syn keyword semaBuiltin memory/messages memory/open merge message/content message/role message/with-image message?
syn keyword semaBuiltin min mod modulo mutable-array/->vector mutable-array/get mutable-array/length mutable-array/new
syn keyword semaBuiltin mutable-array/push! mutable-array/set! mutable-cell/get mutable-cell/new mutable-cell/set! negative? newline
syn keyword semaBuiltin nil? not nth null? number->string number/to-string number?
syn keyword semaBuiltin numerator odd? otel/configure otel/event otel/llm-span otel/llm-usage otel/retrieval-span
syn keyword semaBuiltin otel/set-attribute otel/set-attributes otel/set-status otel/span otel/tool-span otel/with-session pair?
syn keyword semaBuiltin parallel parallel-settled parameterize partition patch/apply-file path/absolute path/absolute?
syn keyword semaBuiltin path/canonicalize path/dir path/extension path/filename path/join path/relative-to path/stem
syn keyword semaBuiltin path/within? pdf/extract-text pdf/extract-text-pages pdf/metadata pdf/page-count phase pi
syn keyword semaBuiltin pii/detect pio/assemble pio/delay pio/in pio/irq pio/jmp pio/mov
syn keyword semaBuiltin pio/nop pio/out pio/pull pio/push pio/set pio/side pio/wait
syn keyword semaBuiltin pipeline pipeline-settled positive? pow pprint print
syn keyword semaBuiltin print-error println println-error proc/close proc/close-stdin proc/exit-code proc/kill
syn keyword semaBuiltin proc/read-stderr proc/read-stdout proc/run proc/running? proc/spawn proc/wait proc/write-stdin
syn keyword semaBuiltin procedure? promise-forced? promise? prompt/append prompt/concat prompt/diff prompt/difference
syn keyword semaBuiltin prompt/fill prompt/intersection prompt/messages prompt/render prompt/set-system prompt/slots prompt/template
syn keyword semaBuiltin prompt/union prompt? pty/close pty/exit-code pty/kill pty/read pty/resize
syn keyword semaBuiltin pty/running? pty/spawn pty/wait pty/write quotient raise range
syn keyword semaBuiltin rational? rationalize read read-line read-many read-stdin read/all
syn keyword semaBuiltin read/string real-part real? record? redact/spans reduce regex/find-all
syn keyword semaBuiltin regex/match regex/match? regex/replace regex/replace-all regex/split remainder rest
syn keyword semaBuiltin retry reverse round route/from-tools route/prefix secret/detect secret/redact
syn keyword semaBuiltin sema/check-file sema/check-string serial/close serial/list serial/open serial/read-line serial/send
syn keyword semaBuiltin serial/write settled-partition settled/err? settled/ok? shell shell/quote sin
syn keyword semaBuiltin sleep some-> some? sort sort-by spy sqrt
syn keyword semaBuiltin step str stream/available? stream/byte-buffer stream/close stream/copy stream/flush
syn keyword semaBuiltin stream/from-bytes stream/from-string stream/open-input stream/open-output stream/read stream/read-all stream/read-byte
syn keyword semaBuiltin stream/read-line stream/readable? stream/to-bytes stream/to-string stream/type stream/write stream/write-byte
syn keyword semaBuiltin stream/write-string stream? string->float string->number string-ci=? string/after string/after-last
syn keyword semaBuiltin string/append string/before string/before-last string/between string/byte-length string/camel-case string/capitalize
syn keyword semaBuiltin string/chars string/chop-end string/chop-start string/codepoints string/contains? string/empty? string/ends-with?
syn keyword semaBuiltin string/ensure-end string/ensure-start string/foldcase string/from-codepoints string/headline string/index-of string/intern
syn keyword semaBuiltin string/join string/kebab-case string/last-index-of string/length string/lines string/lower string/map
syn keyword semaBuiltin string/normalize string/number? string/pad-left string/pad-right string/pascal-case string/ref string/remove
syn keyword semaBuiltin string/repeat string/replace string/replace-first string/replace-last string/reverse string/slice string/snake-case
syn keyword semaBuiltin string/split string/starts-with? string/take string/title-case string/to-char string/to-keyword string/to-list
syn keyword semaBuiltin string/to-number string/to-symbol string/to-utf8 string/trim string/trim-left string/trim-right string/truncate-width
syn keyword semaBuiltin string/unwrap string/upper string/width string/word-wrap string/words string/wrap string?
syn keyword semaBuiltin symbol/to-string symbol? sys/arch sys/args sys/check-signals sys/config-dir sys/cwd
syn keyword semaBuiltin sys/elapsed sys/env-all sys/home-dir sys/hostname sys/interactive? sys/interner-stats sys/on-signal
syn keyword semaBuiltin sys/os sys/pid sys/platform sys/sema-home sys/set-env sys/temp-dir sys/term-size
syn keyword semaBuiltin sys/tty sys/user sys/which take take-while tap tar/create
syn keyword semaBuiltin tar/extract term/bell term/black term/blue term/bold term/clear term/clear-below
syn keyword semaBuiltin term/clear-line term/cursor-home term/cursor-position term/cyan term/dim term/disable-bracketed-paste term/disable-focus-events
syn keyword semaBuiltin term/disable-kitty-keys! term/disable-mouse term/enable-bracketed-paste term/enable-focus-events term/enable-kitty-keys! term/enable-mouse term/enter-alt-screen
syn keyword semaBuiltin term/flush term/gray term/green term/hide-cursor term/inverse term/italic term/leave-alt-screen
syn keyword semaBuiltin term/magenta term/move-to term/query-cursor-position term/query-kitty-keys term/query-primary-da term/query-secondary-da term/red
syn keyword semaBuiltin term/restore-cursor term/rgb term/save-cursor term/set-title term/show-cursor term/spinner-start term/spinner-stop
syn keyword semaBuiltin term/spinner-update term/strikethrough term/strip term/style term/supports-kitty-keys? term/underline term/white
syn keyword semaBuiltin term/with-bracketed-paste term/with-focus-events term/with-kitty-keys term/write-at term/yellow text/chunk text/chunk-by-separator
syn keyword semaBuiltin text/clean-whitespace text/excerpt text/normalize-newlines text/split-sentences text/strip-html text/trim-indent text/truncate
syn keyword semaBuiltin text/word-count time time-ms time/add time/date-parts time/diff time/format
syn keyword semaBuiltin time/ms time/now time/parse time/tick toml/decode toml/encode tool/description
syn keyword semaBuiltin tool/invoke tool/name tool/parameters tool/policy-subjects tool? tools->routes truncate
syn keyword semaBuiltin type type-of update-in utf8/to-string uuid/v4 vals values
syn keyword semaBuiltin vector vector->list vector-store/add vector-store/count vector-store/create vector-store/delete vector-store/open
syn keyword semaBuiltin vector-store/save vector-store/search vector/cosine-similarity vector/distance vector/dot-product vector/normalize vector?
syn keyword semaBuiltin web/user-agent web/user-agent-data workflow/approval workflow/check workflow/checkpoint workflow/mcp-handle workflow/phase
syn keyword semaBuiltin workflow/policy-without workflow/run workflow/run-form workflow/step workflow/tool-call workflow/tool-result ws/close
syn keyword semaBuiltin ws/connect ws/connected? ws/listen ws/ping ws/recv ws/recv-timeout ws/send
syn keyword semaBuiltin zero? zip zip/create zip/extract zip/list

" Runtime aliases omitted from the documentation index.
syn keyword semaBuiltin caddr char->integer char->string char-alphabetic? char-downcase char-numeric? char-upcase char-upper-case?
syn keyword semaBuiltin char-whitespace? i64-array/fold i64-array/length i64-array/map i64-array/ref i64-array/set! i64-array/sum i64-array?
syn keyword semaBuiltin integer->char keyword->string path/basename path/dirname path/ext stream/writable? string->char string->keyword
syn keyword semaBuiltin string->list string->symbol string->utf8 string-append string-length string-ref substring symbol->string
syn keyword semaBuiltin time/now-ms utf8->string

" ---------- Quoting shortcuts -------------------------------------------

syn match semaQuote /\v'[^ \t()\[\]{}]+/
syn match semaQuote /\v`[^ \t()\[\]{}]+/
syn match semaUnquote /,@\?/

" ---------- Highlight Links ---------------------------------------------

hi def link semaComment Comment
hi def link semaTodo Todo
hi def link semaString String
hi def link semaRegex String
hi def link semaStringEscape SpecialChar
hi def link semaNumber Number
hi def link semaBoolean Boolean
hi def link semaConstant Constant
hi def link semaKeyword Type
hi def link semaSpecial Keyword
hi def link semaThreading Keyword
hi def link semaOperator Operator
hi def link semaDefineVar Identifier
hi def link semaDefineFun Function
hi def link semaSetTarget Identifier
hi def link semaBuiltin Function
hi def link semaQuote Special
hi def link semaUnquote Special
hi def link semaCharacter Character
hi def link semaParens Delimiter

let b:current_syntax = 'sema'
