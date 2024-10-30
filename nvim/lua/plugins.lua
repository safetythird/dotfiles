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
			{ "<C-p>",      ":FzfLua files<CR>",       desc = "Fuzzy find files by path" },
			{ "<C-b>",      ":FzfLua buffers<CR>",     desc = "Fuzzy find files" },
			{ "<Leader>gf", ":FzfLua grep<CR>",        desc = "Fuzzy find in files" },
			{ "<Leader>gb", ":FzfLua grep_curbuf<CR>", desc = "Fuzzy find in current buffer" },
			{ "<Leader>gl", ":FzfLua grep_last<CR>",   desc = "Fuzzy find in files with last search word" },
			{ "<Leader>gw", ":FzfLua grep_cword<CR>",  desc = "Fuzzy find in files with word under cursor" },
			{ "<Leader>gW", ":FzfLua grep_cWORD<CR>",  desc = "Fuzzy find in files with WORD under cursor" }
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
		lazy = false,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = {
			{ '<Leader>t', ':NvimTreeToggle<CR>' }
		},
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
		keys = {
			{ '<Leader>on',  ':ObsidianNew ' },
			{ '<Leader>od',  ':vsplit<CR>:ObsidianToday<CR>' },
			{ '<Leader>oll', ':vsplit<CR>:ObsidianLink <CR>',    'v' },
			{ '<Leader>oln', ':vsplit<CR>:ObsidianLinkNew <CR>', 'v' },
		},
		lazy = true,
		ft = "markdown",
		opts = {
			dir = "~/Documents/wiki",
			completion = {
				nvim_cmp = true,
			},
			open_app_foreground = true,
			daily_notes = {
				folder = "Dailies",
			},
			note_id_func = function(title)
				-- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
				local suffix = ""
				if title ~= nil then
					suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
				else
					for _ = 1, 4 do
						suffix = suffix .. string.char(math.random(65, 90))
					end
				end
				-- IDs look like "230415-foo-bar"
				return tostring(os.date("%y%m%d")) .. "-" .. suffix
			end
		}
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim"
		},
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
	{
		"glepnir/lspsaga.nvim",
		event = "LspAttach",
		opts = {
			lightbulb = {
				-- Make it so the code action lightbulb doesn't mess with the gutter
				sign = false,
			},
		},
		keys = {
			{ '<Leader>a',  ':Lspsaga code_action<CR>' },
			{ '<Leader>rf', ':Lspsaga rename<CR>',                                                                                desc = "Rename in file" },
			{ '<Leader>rp', ':Lspsaga rename ++project<CR>',                                                                      desc = "Rename in project" },
			{ 'gh',         ':Lspsaga hover_doc<CR>' },
			{ 'gpp',        ':Lspsaga peek_definition<CR>' },
			{ 'gpt',        ':Lspsaga peek_type_definition<CR>' },
			{ 'gd',         ':Lspsaga goto_definition<CR>' },
			{ 'gl',         ':Lspsaga finder<CR>' },
			{ '[e',         function() require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR }) end, desc = "Go to next error diagnostic" },
			{ ']e',         function() require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR }) end, desc = "Go to previous error diagnostic" },
			{ '<Leader>e',  ':Lspsaga show_line_diagnostics<CR>' },
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
