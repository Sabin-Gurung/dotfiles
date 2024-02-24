local function nerd_tree_toggle()
    vim.cmd[[NERDTreeToggle
    silent NERDTreeMirror]]
end
vim.keymap.set('n', '<leader>ft', nerd_tree_toggle, {desc = "nerd_tree_toggle"})

vim.cmd [[
nnoremap <leader>fl :NERDTreeFind<CR>
nnoremap <leader>gs :Git<CR>
nnoremap <leader>ga :Git blame<CR>
nnoremap <leader>ou :UndotreeToggle<CR>
augroup MY_AU_GROUP
    autocmd!
    autocmd filetype python nnoremap <buffer> <localleader>ef :sp term://python3 %<CR>
    autocmd filetype lua nnoremap <buffer> <localleader>ef :luafile %<CR>
    autocmd filetype TelescopePrompt let b:autopairs_enabled = 0
augroup END
let g:conjure#mapping#def_word = v:false
let g:conjure#client#clojure#nrepl#mapping#refresh_changed = v:false
let g:conjure#client#clojure#nrepl#connection#auto_repl#enabled = v:false
]]

vim.g.undotree_SetFocusWhenToggle=1
vim.g.NERDTreeMinimalUI=1
vim.g.NERDTreeWinSize=40
require('lualine').setup {
    options = {
        icons_enabled = false,
        component_separators = '|',
        section_separators = '',
    },
}

