local telescope = require('telescope')
local actions = require "telescope.actions"
local builtin = require "telescope.builtin"
local action_state = require "telescope.actions.state"

local file_opts = {previewer = false, find_command={ 'fd', '--type', 'f', '--follow', '--hidden', '--exclude', '.git' }}
telescope.setup{
    defaults = {
        layout_strategy = "vertical",
        sorting_strategy = "ascending",
        layout_config = { prompt_position = "top" }
    },
    pickers = {
        colorscheme  = {
            enable_preview = true
        },
        find_files = file_opts,
        git_files = file_opts,
        buffers = {
            previewer = false,
            mappings = {
                i = {
                    ["<c-k>"] = actions.delete_buffer + actions.move_to_top
                }
            }
        },
    },
    extensions = {
        file_browser = {
            previewer = false,
            dir_icon = "▸",
            theme = "ivy",
            git_status = false
        }
    }
}

vim.keymap.set('n', '<leader><space>', builtin.commands, {desc = 'telescope commands'})
vim.keymap.set('n', '<c-p>', function() if not pcall(builtin.git_files, {show_untracked = true}) then builtin.find_files() end end, {desc = 'telescope project files'})
vim.keymap.set('n', '<leader>bb', builtin.buffers, {desc = 'telescope buffers'})
vim.keymap.set('n', '<leader>fC', builtin.colorscheme, {desc = 'telescope colors'})
vim.keymap.set('n', '<leader>ff', ":Telescope file_browser<CR>", {desc = 'telescope find browser'})
vim.keymap.set('n', '<leader>fm', builtin.marks, {desc = 'telescope marks'})
vim.keymap.set('n', '<leader>fM', builtin.keymaps, {desc = 'telescope keymap'})
vim.keymap.set('n', '<leader>fT', builtin.filetypes, {desc = 'telescope filetypes'})
vim.keymap.set('n', '<leader>fo', builtin.oldfiles, {desc = 'telescope oldfiles'})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {desc = 'telescope help_tags'})
vim.keymap.set('n', '<leader>fr', builtin.command_history, {desc = 'telescope command_history'})
vim.keymap.set('n', '<leader>fs', builtin.live_grep, {desc = 'telescope live_grep'})
vim.keymap.set('n', '<leader>fS', ':Telescope grep_string search=', {desc = 'telescope search query word'})
vim.keymap.set('n', '<leader>f/', builtin.search_history, {desc = 'telescope search history'})
vim.keymap.set('n', '<leader>f*', builtin.grep_string, {desc = 'telescope search current word'})
vim.keymap.set('n', 'z=', builtin.spell_suggest, {desc = 'telescope spell suggest'})
vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = 'telescope git branches' })
vim.keymap.set('n', '<leader>gh', builtin.git_bcommits, {desc = 'telescope git commits'})
vim.keymap.set('n', '<leader>p', telescope.extensions.neoclip.default, {desc = 'telescope neoclip'})

vim.keymap.set('n', '<leader>vrc', function()
  local found = vim.fn.systemlist(
    'fd . -t f --follow --hidden --exclude .git ' .. vim.fn.expand('~/.config_user/')
  )

  require('telescope.builtin').find_files {
    prompt_title = 'Vrc > ',
    finder = require('telescope.finders').new_table { results = found },
    sorter = require('telescope.config').values.generic_sorter {},
  }
end, { desc = 'Nvim config' })

require('telescope').load_extension('fzf')
require("telescope").load_extension "file_browser"

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

local function save_current_buffer_via_yazi()
  local target_buf = vim.api.nvim_get_current_buf()

  require("yazi").yazi({
    open_file_function = function(chosen_path)
      if not chosen_path then return end

      if vim.fn.isdirectory(chosen_path) == 1 then
        local path_prefix = chosen_path:gsub("/$", "") .. "/"

        vim.ui.input({
          prompt = "Save to path: ",
          default = path_prefix,
        }, function(input_path)
          if not input_path or input_path == "" or input_path == path_prefix then
            return
          end

          -- Extract the directory portion of whatever the user typed
          -- (e.g., /path/to/chosen/new_folder/filename.txt -> /path/to/chosen/new_folder)
          local target_dir = vim.fn.fnamemodify(input_path, ":h")

          -- Ensure the directory structure exists before writing
          if vim.fn.isdirectory(target_dir) == 0 then
            vim.fn.mkdir(target_dir, "p")
          end

          vim.api.nvim_buf_call(target_buf, function()
            vim.cmd("write " .. vim.fn.fnameescape(input_path))
          end)
        end)
      else
        -- If you selected an actual file in Yazi, overwrite it directly
        vim.api.nvim_buf_call(target_buf, function()
          vim.cmd("write " .. vim.fn.fnameescape(chosen_path))
        end)
      end
    end
  })
end

vim.keymap.set("n", "<leader>sw", save_current_buffer_via_yazi, { desc = "Save Buffer As via Yazi" })
