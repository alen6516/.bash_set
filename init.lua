-- known issues
-- 	- backspace doesn't work
-- 	- ctrl-h can't map under mobaxterm
-- 	- mouse can't copy words
-- 	- code snippet in #ifdef #endif is treated as comment syntax
-- 		- need to check tree-sitting syntax group

-- BASIC OPTIONS {
    local opt = vim.opt
    local g = vim.g

    -- Line numbers
    opt.number = true               -- show absolute line number
    --opt.relativenumber = true       -- show relative line numbers

    -- Tabs & indentation
    opt.tabstop = 4                 -- 1 tab = 4 spaces
    opt.shiftwidth = 4              -- indentation rule
    opt.expandtab = true            -- convert tabs to spaces
    --opt.smartindent = true          -- autoindent new lines

    -- Wrapping & scrolling
    opt.wrap = false                -- disable line wrap
    opt.scrolloff = 8               -- keep cursor 8 lines from screen edge

    -- Search
    opt.ignorecase = true           -- case insensitive search
    opt.smartcase = true            -- unless search contains capital letters
    opt.incsearch = true            -- search as you type
    opt.hlsearch = true             -- highlight search results

    -- Mouse and clipboard
    opt.mouse = "i"                 -- enable mouse support
    --opt.clipboard = "unnamedplus"  -- use system clipboard

    -- UI
    opt.cursorline = true           -- highlight current line
    opt.termguicolors = true        -- true color support
    opt.signcolumn = "yes"          -- always show sign column

    -- Performance
    opt.updatetime = 300            -- faster update
    opt.timeoutlen = 500            -- faster key sequence timeout

    -- File handling
    opt.backup = false              -- disable backup
    opt.writebackup = false
    opt.swapfile = false
    opt.undofile = true             -- persistent undo
    opt.undodir = vim.fn.stdpath("data") .. "/undo"

    -- Leader key
    g.mapleader = "\\"               -- \ as leader key

    -- Key mapping
    vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>", { desc = "Clear search highlight" })
    vim.keymap.set("n", "<BS>", "10h", { noremap = true, silent = true }) -- Left
    vim.keymap.set("n", "<C-h>", "10h", { noremap = true, silent = true }) -- Left
    vim.keymap.set("n", "<C-l>", "10l", { noremap = true, silent = true }) -- Right
    vim.keymap.set("n", "<C-j>", "10j", { noremap = true, silent = true }) -- Down
    vim.keymap.set("n", "<C-k>", "10k", { noremap = true, silent = true }) -- Up
    vim.keymap.set("n", "<C-d>", "10j", { noremap = true, silent = true }) -- Down
    vim.keymap.set("n", "<C-u>", "10k", { noremap = true, silent = true }) -- Up

    -- make # highlight word but don't jump
    vim.keymap.set('n', '#', function()
        local word = vim.fn.expand('<cword>')
        vim.fn.setreg('/', '\\<' .. word .. '\\>')
        vim.o.hlsearch = true
    end, { silent = true })
-- }


-- Bootstrap lazy.nvim
vim.opt.runtimepath:prepend("~/.config/nvim/lazy/lazy.nvim")

-- Plugin list
require("lazy").setup({
    -- LSP Config
    { "neovim/nvim-lspconfig" },

    -- File explorer
    { "nvim-tree/nvim-tree.lua", dependencies = { "nvim-tree/nvim-web-devicons" } },

    -- Fuzzy finder (needs ripgrep)
    { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },

    -- Syntax highlighting
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

    -- Color theme
    --{ "folke/tokyonight.nvim" },

    -- Statusline
    { "nvim-lualine/lualine.nvim" },
})

-- ========== Plugin Configurations ========== --

-- LSP Setup {
    -- LSP Setup (basic)
    local lspconfig = require("lspconfig")

    -- Example: Python
    lspconfig.pyright.setup({})     -- requires `npm install -g pyright`

    -- Example: C/C++
    lspconfig.clangd.setup({})      -- requires `sudo apt install clangd -y`

    -- Key mappings for LSP (ctags-like)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to Declaration" })
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to Implementation" })
    vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Find References" })
    vim.keymap.set("n", "K",  vim.lsp.buf.hover, { desc = "Hover Info" })

    -- Use LSP for tag-style navigation
    vim.keymap.set("n", "<C-]>", vim.lsp.buf.definition, { desc = "LSP Go to Definition" })
    vim.keymap.set("n", "<C-t>", "<C-o>", { desc = "Jump back in jumplist" })

-- }

-- Example: Setup treesitter
require('nvim-treesitter.configs').setup {
  ensure_installed = { "c", "cpp", "lua", "vim", "bash", "python", "rust", "json", "yaml", "markdown" }, -- languages you care about
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
}

-- set color theme
--vim.cmd.colorscheme("tokyonight")

-- Example: Setup Telescope {
require('telescope').setup {}
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })    -- Find files
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })      -- Grep text
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fs', builtin.lsp_workspace_symbols, {})                        -- Search symbols
vim.keymap.set('n', '<leader>cf', builtin.lsp_incoming_calls, { desc = "Find Callers" })    -- find callers
vim.keymap.set('n', '<leader>ft', builtin.tags, {})                                         -- Search tags
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })      -- Search tags


vim.keymap.set('n', '<leader>fa', function() builtin.find_files({ hidden = true, no_ignore = true }) end, { desc = 'Find all files' })
--vim.keymap.set('n', '<leader>fc', function() builtin.find_files({ find_command = { 'fd', '--type', 'f', '--extension', 'c' } }) end, { desc = 'Find .c files' })
vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = 'Recently opened files' })
--vim.keymap.set('n', '<leader>fp', function() builtin.find_files({ cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1] }) end, { desc = 'Find from Git root' })
--vim.keymap.set("n", "<leader>fb", function() require("telescope").extensions.file_browser.file_browser({ path = "%:p:h", select_buffer = true }) end, { desc = "File browser" })

-- }

-- Example: Setup nvim-tree
require("nvim-tree").setup()

-- Example: Setup lualine
require('lualine').setup{}
