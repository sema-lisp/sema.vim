# sema.vim

Vim and Neovim support for [Sema](https://sema-lang.com) — a Lisp with first-class LLM primitives. Provides syntax highlighting, filetype detection, and Lisp-aware editor settings for `.sema` files.

- **Homepage**: [sema-lang.com](https://sema-lang.com)
- **Playground**: [sema.run](https://sema.run)
- **Source**: [github.com/sema-lisp/sema.vim](https://github.com/sema-lisp/sema.vim)
- **Author**: Helge Sverre

## Features

- **Filetype detection** — `.sema` files are automatically detected as `sema`.
- **Syntax highlighting** — special forms, builtins (including LLM/agent primitives like `llm/chat`, `agent/run`, `defagent`, `deftool`), threading macros (`->`, `->>`, `as->`), keyword literals, strings with escapes, numbers, booleans, character literals, quoting/unquoting, line (`;`) and block (`#| … |#`) comments, and definition-name highlighting.
- **Lisp-aware editing** — `lisp` mode with a curated `lispwords` list (including Sema forms such as `defagent`, `deftool`, `with-budget`), 2-space indentation, and `iskeyword` extended for Sema identifiers (`!?/-<>*#`).
- **Comment settings** — `commentstring` and `comments` configured for `;` line comments.

This is a pure Vimscript plugin — no external dependencies, works in both Vim and Neovim.

## Installation

Because this repository uses the standard plugin layout (`ftdetect/`, `ftplugin/`, `syntax/` at the root), no runtimepath override is needed — install it like any other plugin.

### vim-plug

```vim
Plug 'sema-lisp/sema.vim'
```

### lazy.nvim

```lua
{ "sema-lisp/sema.vim" }
```

### packer.nvim

```lua
use "sema-lisp/sema.vim"
```

### Native packages (`:packadd` / Vim 8+ & Neovim)

```bash
git clone https://github.com/sema-lisp/sema.vim.git \
  ~/.vim/pack/plugins/start/sema.vim
# Neovim:
git clone https://github.com/sema-lisp/sema.vim.git \
  ~/.local/share/nvim/site/pack/plugins/start/sema.vim
```

### Manual

Copy the directories into your Vim (`~/.vim`) or Neovim (`~/.config/nvim`) config:

```bash
git clone https://github.com/sema-lisp/sema.vim.git
cp -r sema.vim/{ftdetect,ftplugin,syntax} ~/.vim/
```

## Requirements

- **Vim 7+ or Neovim** — the plugin is pure Vimscript with no runtime dependencies.
- The [`sema`](https://sema-lang.com) binary is only needed to *run* Sema code, not for editing. Install it from the [Sema project](https://github.com/HelgeSverre/sema).

## LSP Support (optional)

Sema ships a built-in language server (`sema lsp`) providing completions, hover docs, go-to-definition, find references, rename, signature help, diagnostics, document symbols, and code lens. This plugin does not start it for you — wire it up with your LSP client of choice.

### nvim-lspconfig (Neovim built-in LSP)

```lua
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'sema',
  callback = function()
    vim.lsp.start({
      name = 'sema',
      cmd = { 'sema', 'lsp' },
      root_dir = vim.fs.dirname(vim.fs.find({ 'sema.toml', '.git' }, { upward = true })[1]),
    })
  end,
})
```

### coc.nvim

Add to `:CocConfig`:

```json
{
  "languageserver": {
    "sema": {
      "command": "sema",
      "args": ["lsp"],
      "filetypes": ["sema"]
    }
  }
}
```

The Sema LSP server also emits a custom `sema/evalResult` notification for inline evaluation results; displaying it requires a custom client handler (see the Sema documentation).

## Highlighting Groups

| Group              | What it covers                                        |
| ------------------ | ----------------------------------------------------- |
| `semaSpecial`      | Special forms (`define`, `lambda`, `if`, `defagent`…) |
| `semaBuiltin`      | Builtin functions (`map`, `llm/chat`, `file/read`…)   |
| `semaThreading`    | Threading macros (`->`, `->>`, `as->`)                |
| `semaOperator`     | Arithmetic/comparison operators (`+`, `-`, `<=`…)     |
| `semaKeyword`      | Keyword literals (`:model`, `:temperature`…)          |
| `semaString`       | String literals                                       |
| `semaStringEscape` | Escape sequences in strings                           |
| `semaNumber`       | Integer and float literals                            |
| `semaBoolean`      | `#t`, `#f`, `true`, `false`                           |
| `semaConstant`     | `nil`                                                 |
| `semaCharacter`    | Character literals (`#\a`, `#\space`…)                |
| `semaComment`      | Line comments (`;`)                                   |
| `semaBlockComment` | Block comments (`#\| … \|#`)                          |
| `semaTodo`         | TODO/FIXME/XXX/HACK/NOTE in comments                  |
| `semaDefineVar`    | Names bound by `(define name …)` / `set!`             |
| `semaDefineFun`    | Names bound by `(define (f …))`, `defun`, `defmacro`… |
| `semaQuote`        | Quote (`'`) and quasiquote (`` ` ``) prefixes         |
| `semaUnquote`      | Unquote (`,`) and unquote-splicing (`,@`)             |
| `semaParens`       | Parentheses, brackets, and braces                     |

Override any group in your colorscheme to customise appearance.

## License

MIT
