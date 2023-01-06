local telescope = require('telescope')
local filesOpts = {previewer = false, find_command={"rg", "--ignore", "-L", "--hidden", "--files"}}
telescope.setup{
    defaults = {
        layout_strategy = "vertical",
        sorting_strategy = "ascending",
        layout_config = { prompt_position = "top" }
    },
    pickers = {
        find_files = filesOpts,
        git_files = filesOpts,
        buffers = filesOpts,
    }
}
local tel_actions = require "telescope.actions"
local tel_builtin = require "telescope.builtin"
local tel_action_state = require "telescope.actions.state"
vim.api.nvim_create_user_command("TelescopeProjects", function()
    tel_builtin.find_files({find_command={"fd", ".git$", "-t", "d", "-H", "/Users/sabingurung/workspace", "|", "echo", "hello"},
    prompt_prefix = "Projects > ",
    attach_mappings = function (prompt_buffer, _)
        tel_actions.select_default:replace(function()
            local text = tel_action_state.get_selected_entry()[1]:gsub(".git", "")
            tel_actions.close(prompt_buffer)
            vim.cmd("cd " .. text)
            tel_builtin.git_files()
        end)
        return true
    end})
end, {})
vim.api.nvim_create_user_command("TelescopePFiles", function() if not pcall(tel_builtin.git_files, {}) then tel_builtin.find_files() end end, {})
vim.keymap.set('n', '<leader><space>', tel_builtin.commands, {})
vim.keymap.set('n', '<c-p>', '<cmd>TelescopePFiles<cr>')
vim.keymap.set('n', '<leader>bb', tel_builtin.buffers, {})
vim.keymap.set('n', '<leader>fC', tel_builtin.colorscheme, {})
vim.keymap.set('n', '<leader>fj', tel_builtin.jumplist, {})
vim.keymap.set('n', '<leader>fm', tel_builtin.marks, {})
vim.keymap.set('n', '<leader>fM', tel_builtin.keymaps, {})
vim.keymap.set('n', '<leader>fT', tel_builtin.filetypes, {})
vim.keymap.set('n', '<leader>fo', tel_builtin.oldfiles, {})
vim.keymap.set('n', '<leader>fh', tel_builtin.help_tags, {})
vim.keymap.set('n', '<leader>fr', tel_builtin.command_history, {})
vim.keymap.set('n', '<leader>fs', tel_builtin.live_grep, {})
vim.keymap.set('n', '<leader>fS', ':Telescope grep_string search=', {})
vim.keymap.set('n', '<leader>f/', tel_builtin.search_history, {})
vim.keymap.set('n', '<leader>f*', tel_builtin.grep_string, {})
vim.keymap.set('n', '<leader>fz', tel_builtin.spell_suggest, {})
vim.keymap.set('n', '<leader>gb', tel_builtin.git_branches, { desc = "remap" })
vim.keymap.set('n', '<leader>gh', tel_builtin.git_bcommits, {})

pcall(require('telescope').load_extension,'fzf')
