local telescope = require('telescope')
local actions = require "telescope.actions"
local builtin = require "telescope.builtin"
local action_state = require "telescope.actions.state"

local file_opts = {previewer = false, find_command={"rg", "--ignore", "-L", "--hidden", "--files"}}
telescope.setup{
    defaults = {
        layout_strategy = "vertical",
        sorting_strategy = "ascending",
        layout_config = { prompt_position = "top" }
    },
    pickers = {
        find_files = file_opts,
        git_files = file_opts,
        buffers = file_opts,
    }
}

vim.keymap.set('n', '<leader><space>', builtin.commands, {})
vim.keymap.set('n', '<c-p>', function() if not pcall(builtin.git_files, {}) then builtin.find_files() end end, {})
vim.keymap.set('n', '<leader>bb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fC', builtin.colorscheme, {})
vim.keymap.set('n', '<leader>fj', builtin.jumplist, {})
vim.keymap.set('n', '<leader>fm', builtin.marks, {})
vim.keymap.set('n', '<leader>fM', builtin.keymaps, {})
vim.keymap.set('n', '<leader>fT', builtin.filetypes, {})
vim.keymap.set('n', '<leader>fo', builtin.oldfiles, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fr', builtin.command_history, {})
vim.keymap.set('n', '<leader>fs', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fS', ':Telescope grep_string search=', {})
vim.keymap.set('n', '<leader>f/', builtin.search_history, {})
vim.keymap.set('n', '<leader>f*', builtin.grep_string, {})
vim.keymap.set('n', '<leader>fz', builtin.spell_suggest, {})
vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = "remap" })
vim.keymap.set('n', '<leader>gh', builtin.git_bcommits, {})

pcall(require('telescope').load_extension,'fzf')

vim.api.nvim_create_user_command("TelescopeProjects", function()
    builtin.find_files({find_command={"fd", ".git$", "-t", "d", "-H", "/Users/sabingurung/workspace", "|", "echo", "hello"},
    prompt_prefix = "Projects > ",
    attach_mappings = function (prompt_buffer, _)
        actions.select_default:replace(function()
            local text = action_state.get_selected_entry()[1]:gsub(".git", "")
            actions.close(prompt_buffer)
            vim.cmd("cd " .. text)
            builtin.git_files()
        end)
        return true
    end})
end, {})

