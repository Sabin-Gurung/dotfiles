local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function() vim.highlight.on_yank() end,
    group = highlight_group,
    pattern = '*',
})

require('lualine').setup { options = { icons_enabled = false, component_separators = '|', section_separators = '', }, }

vim.g.undotree_SetFocusWhenToggle=1
vim.g.NERDTreeMinimalUI=1
vim.g.NERDTreeWinSize=40
vim.cmd [[
function! ToggleNERDTree()
NERDTreeToggle
silent NERDTreeMirror
endfunction
nnoremap <leader>ft :call ToggleNERDTree()<CR>
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
]]


