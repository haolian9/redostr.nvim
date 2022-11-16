an example to get the redo commands used by `.`

## status: just-works
* it may crash nvim due to using ffi
* the generated redostr is opinionated

## usage
* `lua =require'redostr'()`
* add it to status line: `:set statusline=%{v:lua.require'redostr'()}`

## special thanks
* ii14 who pointed out the use of get_inserted() thus made this plugin possible
