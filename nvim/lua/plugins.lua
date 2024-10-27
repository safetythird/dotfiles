return {
	{
		"williamboman/mason.nvim",
		config = true
	},
	{
		'echasnovski/mini.nvim',
		version = false,
		config = function()
			require('mini.surround').setup()
			require('mini.pairs').setup()
			require('mini.comment').setup()
			require('mini.ai').setup()
		end
	},
	{
		"ibhagwan/fzf-lua",
		-- optional for icon support
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = true,
		keys = {
			{ "<C-p>", ":FzfLua files<CR>", desc = "Fuzzy find files by path"},
			{ "<C-b>", ":FzfLua buffers<CR>", desc = "Fuzzy find files"},
			{ "<Leader>gf", ":FzfLua grep<CR>", desc = "Fuzzy find in files"},
			{ "<Leader>gb", ":FzfLua grep_curbuf<CR>", desc = "Fuzzy find in current buffer"},
			{ "<Leader>gl", ":FzfLua grep_last<CR>", desc = "Fuzzy find in files with last search word"},
			{ "<Leader>gw", ":FzfLua grep_cword<CR>", desc = "Fuzzy find in files with word under cursor"},
			{ "<Leader>gW", ":FzfLua grep_cWORD<CR>", desc = "Fuzzy find in files with WORD under cursor"}
		}
	},
	{
		"EdenEast/nightfox.nvim",
		config = function()
			vim.o.termguicolors = true
			vim.cmd('colorscheme duskfox')
		end
	},
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1

			local nvimtree = require("nvim-tree")

			nvimtree.setup({
				update_focused_file = {
					enable = true,
					update_root = false
				}
			})
		end
	},
	"tpope/vim-fugitive",
	{
		"nvim-treesitter/nvim-treesitter",
		config = true,
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"windwp/nvim-ts-autotag",
			"RRethy/nvim-treesitter-endwise",
		},
	},

	{
		"epwalsh/obsidian.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"neovim/nvim-lspconfig",
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			-- Snippets
			"dcampos/nvim-snippy",
			"dcampos/cmp-snippy",
		},
		config = function() require("cmpsetup") end
	},
	{
		"glepnir/lspsaga.nvim",
		event = "LspAttach",
		opts = {
			lightbulb = {
				sign = false,
			},
		},
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
			--Please make sure you install markdown and markdown_inline parser
			{ "nvim-treesitter/nvim-treesitter" }
		}
	},
	{
		"github/copilot.vim",
		cond = function()
			local copilot_enable = os.getenv("NVIM_COPILOT_ENABLE")
			if (copilot_enable == "" or copilot_enable == nil) then
				return false
			end
			return true
		end,
		config = function()
			vim.g.copilot_node_command = "~/.nvm/versions/node/v16.20.0/bin/node"
			vim.cmd('imap <silent><script><expr> <C-J> copilot#Accept("\\<CR>")')
			vim.g.copilot_no_tab_map = true
			vim.g.copilot_filetypes = { markdown = false }
		end
	},

	-- Language specific
	{ "Glench/Vim-Jinja2-Syntax", ft = "jinja" },
	{
		"ray-x/go.nvim",
		ft = "go",
		config = function()
			require("go").setup()
			local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*.go",
				callback = function()
					require('go.format').goimport()
				end,
				group = format_sync_grp,
			})
		end
	},
}
