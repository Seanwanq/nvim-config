return {
	{
		"dstein64/vim-startuptime",
		cmd = "StartupTime",
		init = function()
			vim.g.startuptime_tries = 10
		end,
	},
	{
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
			"TmuxNavigatorProcessList",
		},
		keys = {
			{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
			{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
			{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
			{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
			{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
		},
	},
	{
		"kylechui/nvim-surround",
		version = "^3.0.0",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				ensure_installed = {
					"c",
					"cpp",
					"lua",
					"vim",
					"javascript",
					"html",
					"python",
					"c_sharp",
					"json",
					"toml",
					"csv",
					"rust",
					"markdown",
					"markdown_inline",
				},
				sync_install = false,
				highlight = { enable = true },
				indent = { enable = true },
				rainbow = { enable = true },
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-n>",
						node_incremental = "<C-n>",
						scope_incremental = "<C-s>",
						node_decremental = "<C-m>",
					},
				},
			})
		end,
	},
	{
		"HiPhish/rainbow-delimiters.nvim",
		lazy = false,
		priority = 60,
		config = function()
			require("rainbow-delimiters.setup").setup({

				strategy = {
					[""] = "rainbow-delimiters.strategy.global",
					vim = "rainbow-delimiters.strategy.local",
				},
				query = {
					[""] = "rainbow-delimiters",
					lua = "rainbow-blocks",
				},
				priority = {
					[""] = 110,
					lua = 210,
				},
				highlight = {
					"RainbowDelimiterRed",
					"RainbowDelimiterYellow",
					"RainbowDelimiterBlue",
					"RainbowDelimiterOrange",
					"RainbowDelimiterGreen",
					"RainbowDelimiterViolet",
					"RainbowDelimiterCyan",
				},
			})
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!).
		build = "make install_jsregexp",
		config = function()
			local ls = require("luasnip")

			vim.keymap.set({ "i" }, "<C-K>", function()
				ls.expand()
			end, { silent = true })
			vim.keymap.set({ "i", "s" }, "<C-L>", function()
				ls.jump(1)
			end, { silent = true })
			vim.keymap.set({ "i", "s" }, "<C-J>", function()
				ls.jump(-1)
			end, { silent = true })

			vim.keymap.set({ "i", "s" }, "<C-E>", function()
				if ls.choice_active() then
					ls.change_choice(1)
				end
			end, { silent = true })

			require("luasnip.loaders.from_vscode").lazy_load()
		end,
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
	},
	{
		"rafamadriz/friendly-snippets",
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {},
		lazy = false,
		priority = 100,
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			{
				"neovim/nvim-lspconfig",
				config = function()
					vim.keymap.set(
						"n",
						"gd",
						vim.lsp.buf.definition,
						{ noremap = true, silent = true, desc = "Jump to definition" }
					)

					vim.keymap.set(
						"n",
						"gD",
						vim.lsp.buf.declaration,
						{ noremap = true, silent = true, desc = "Jump to declarance" }
					)

					vim.keymap.set(
						"n",
						"gi",
						vim.lsp.buf.implementation,
						{ noremap = true, silent = true, desc = "Jump to implementation" }
					)

					vim.keymap.set(
						"n",
						"gr",
						vim.lsp.buf.references,
						{ noremap = true, silent = true, desc = "Jump to refence" }
					)

					vim.keymap.set(
						"n",
						"gy",
						vim.lsp.buf.type_definition,
						{ noremap = true, silent = true, desc = "Get the type of function/variable" }
					)

					vim.keymap.set(
						"n",
						"K",
						vim.lsp.buf.hover,
						{ noremap = true, silent = true, desc = "Hover to hint" }
					)

					vim.keymap.set(
						"n",
						"<C-k>",
						vim.lsp.buf.signature_help,
						{ noremap = true, silent = true, desc = "Hint for function parameters" }
					)
				end,
			},
		},

		config = function()
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
			require("mason-lspconfig").setup({
				automatic_enable = {
					exclude = {
						-- "pyright"
					},
				},
			})
			-- vim.lsp.enable("ruff")
		end,
	},

	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
		lazy = false,
		priority = 90,
		config = function()
			local has_words_before = function()
				unpack = unpack or table.unpack
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			local cmp = require("cmp")
			local luasnip = require("luasnip")

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				completion = {
					autocomplete = false,
				},
				mapping = cmp.mapping.preset.insert({
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<s-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
					["<c-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				},
			})
		end,
	},
	{
		"linux-cultist/venv-selector.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
			"mfussenegger/nvim-dap",
			"mfussenegger/nvim-dap-python", --optional
			{ "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
		},
		ft = "python", -- Load when opening Python files
		keys = {
			{ ",v", "<cmd>VenvSelect<cr>" }, -- Open picker on keymap
		},
		opts = { -- this can be an empty lua table - just showing below for clarity.
			search = {}, -- if you add your own searches, they go here.
			options = {}, -- if you add plugin options, they go here.
		},
	},
	{
		"stevearc/conform.nvim",
		opts = {},
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					-- Conform will run multiple formatters sequentially
					-- python = { "ruff" },
					-- You can customize some of the format options for the filetype (:help conform.format)
					rust = { "rustfmt", lsp_format = "fallback" },
					python = { "ruff_format" },
					c = { "clang-format" },
					cpp = { "clang-format" },
				},
				formatters = {
					ruff_format = {
						command = "ruff",
						args = { "format", "--stdin-filename", "$FILENAME", "-" },
						stdin = true,
					},
				},
				-- format_on_save = {
				-- 	-- These options will be passed to conform.format()
				-- 	timeout_ms = 500,
				-- 	lsp_format = "fallback",
				-- },
			})
			vim.api.nvim_create_user_command("Format", function(args)
				local range = nil
				if args.count ~= -1 then
					local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
					range = {
						start = { args.line1, 0 },
						["end"] = { args.line2, end_line:len() },
					}
				end
				require("conform").format({ async = true, lsp_format = "fallback", range = range })
			end, { range = true })
			vim.keymap.set("n", ",f", "<cmd>Format<cr>", { desc = "Format this file" })
		end,
	},
}
