vim.cmd [[
nnoremap <leader>gs :Git<CR>
nnoremap <leader>ga :Git blame<CR>
augroup MY_AU_GROUP
    autocmd!
    autocmd filetype python nnoremap <buffer> <localleader>ef :sp term://python3 %<CR>
    autocmd filetype lua nnoremap <buffer> <localleader>ef :luafile %<CR>
augroup END
let g:conjure#mapping#def_word = v:false
let g:conjure#client#clojure#nrepl#mapping#refresh_changed = v:false
let g:conjure#client#clojure#nrepl#connection#auto_repl#enabled = v:false
]]
