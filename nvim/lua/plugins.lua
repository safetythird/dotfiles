return {
	"tpope/vim-surround",
	{
		"numToStr/Comment.nvim",
		config = function() require("Comment").setup() end
	},
	{
		"junegunn/fzf",
		dependencies = { "junegunn/fzf.vim" }
	},
	"junegunn/fzf.vim",
	{
		"ggandor/leap.nvim",
		config = function()
			local leap = require('leap')
			leap.add_default_mappings()
			leap.opts.highlight_unlabeled_phase_one_targets = true
		end
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
		config = function() require("treesittersetup") end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"windwp/nvim-ts-autotag",
			"RRethy/nvim-treesitter-endwise",
		},
	},

	{ "windwp/nvim-autopairs",    config = function() require("nvim-autopairs").setup {} end },
	{
		"epwalsh/obsidian.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function() require("obsidiansetup") end
	},
	{
		"neovim/nvim-lspconfig",
		config = function() require("lspsetup") end
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

	-- "dense-analysis/ale",

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
