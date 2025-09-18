local trigger_text = ";"

return {
	"saghen/blink.cmp",
	enabled = true,
	-- In case there are breaking changes and you want to go back to the last
	-- working release
	-- https://github.com/Saghen/blink.cmp/releases
	-- version = "v0.13.1",
	dependencies = {
		"moyiz/blink-emoji.nvim",
		"Kaiser-Yang/blink-cmp-dictionary",
	},
	opts = function(_, opts)
		-- I noticed that telescope was extremeley slow and taking too long to open,
		-- assumed related to blink, so disabled blink and in fact it was related
		-- :lua print(vim.bo[0].filetype)
		-- So I'm disabling blink.cmp for Telescope
		opts.enabled = function()
			-- Get the current buffer's filetype
			local filetype = vim.bo[0].filetype
			-- Disable for Telescope buffers
			if filetype == "TelescopePrompt" or filetype == "minifiles" or filetype == "snacks_picker_input" then
				return false
			end
			return true
		end

		-- NOTE: The new way to enable LuaSnip
		-- Merge custom sources with the existing ones from lazyvim
		-- NOTE: by default lazyvim already includes the lazydev source, so not adding it here again
		opts.sources = vim.tbl_deep_extend("force", opts.sources or {}, {
			default = { "lsp", "path", "snippets", "buffer", "emoji", "dictionary" },
			providers = {
				lsp = {
					name = "lsp",
					enabled = true,
					module = "blink.cmp.sources.lsp",
					kind = "LSP",
					min_keyword_length = 0,
					-- When linking markdown notes, I would get snippets and text in the
					-- suggestions, I want those to show only if there are no LSP
					-- suggestions
					--
					-- Enabled fallbacks as this seems to be working now
					-- Disabling fallbacks as my snippets wouldn't show up when editing
					-- lua files
					-- fallbacks = { "snippets", "buffer" },
					score_offset = 90, -- the higher the number, the higher the priority
				},
				path = {
					name = "Path",
					module = "blink.cmp.sources.path",
					score_offset = 25,
					-- When typing a path, I would get snippets and text in the
					-- suggestions, I want those to show only if there are no path
					-- suggestions
					fallbacks = { "snippets", "buffer" },
					-- min_keyword_length = 2,
					opts = {
						trailing_slash = false,
						label_trailing_slash = true,
						get_cwd = function(context)
							return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
						end,
						show_hidden_files_by_default = true,
					},
				},
				buffer = {
					name = "Buffer",
					enabled = true,
					max_items = 3,
					module = "blink.cmp.sources.buffer",
					min_keyword_length = 2,
					score_offset = 15, -- the higher the number, the higher the priority
				},
				snippets = {
					name = "snippets",
					enabled = true,
					max_items = 15,
					min_keyword_length = 2,
					module = "blink.cmp.sources.snippets",
					score_offset = 85, -- the higher the number, the higher the priority
				},
				-- https://github.com/moyiz/blink-emoji.nvim
				emoji = {
					module = "blink-emoji",
					name = "Emoji",
					score_offset = 93, -- the higher the number, the higher the priority
					min_keyword_length = 2,
					opts = { insert = true }, -- Insert emoji (default) or complete its name
				},
				-- https://github.com/Kaiser-Yang/blink-cmp-dictionary
				-- In macOS to get started with a dictionary:
				-- cp /usr/share/dict/words ~/github/dotfiles-latest/dictionaries/words.txt
				--
				-- NOTE: For the word definitions make sure "wn" is installed
				-- brew install wordnet
				dictionary = {
					module = "blink-cmp-dictionary",
					name = "Dict",
					score_offset = 20, -- the higher the number, the higher the priority
					-- https://github.com/Kaiser-Yang/blink-cmp-dictionary/issues/2
					enabled = true,
					max_items = 8,
					min_keyword_length = 3,
					opts = {
						-- -- The dictionary by default now uses fzf, make sure to have it
						-- -- installed
						-- -- https://github.com/Kaiser-Yang/blink-cmp-dictionary/issues/2
						--
						-- Do not specify a file, just the path, and in the path you need to
						-- have your .txt files
						dictionary_directories = { vim.fn.expand("~/github/dotfiles-latest/dictionaries") },
						-- Notice I'm also adding the words I add to the spell dictionary
						dictionary_files = {
							vim.fn.expand("~/github/dotfiles-latest/neovim/neobean/spell/en.utf-8.add"),
							vim.fn.expand("~/github/dotfiles-latest/neovim/neobean/spell/es.utf-8.add"),
						},
						-- --  NOTE: To disable the definitions uncomment this section below
						--
						-- separate_output = function(output)
						--   local items = {}
						--   for line in output:gmatch("[^\r\n]+") do
						--     table.insert(items, {
						--       label = line,
						--       insert_text = line,
						--       documentation = nil,
						--     })
						--   end
						--   return items
						-- end,
					},
				},
				-- -- Third class citizen mf always talking shit
				-- copilot = {
				--   name = "copilot",
				--   enabled = true,
				--   module = "blink-cmp-copilot",
				--   kind = "Copilot",
				--   min_keyword_length = 6,
				--   score_offset = -100, -- the higher the number, the higher the priority
				--   async = true,
				-- },
			},
		})

		opts.cmdline = {
			enabled = true,
		}

		opts.completion = {
			-- accept = {
			--   auto_brackets = {
			--     enabled = true,
			--     default_brackets = { ";", "" },
			--     override_brackets_for_filetypes = {
			--       markdown = { ";", "" },
			--     },
			--   },
			-- },
			--   keyword = {
			--     -- 'prefix' will fuzzy match on the text before the cursor
			--     -- 'full' will fuzzy match on the text before *and* after the cursor
			--     -- example: 'foo_|_bar' will match 'foo_' for 'prefix' and 'foo__bar' for 'full'
			--     range = "full",
			--   },
			menu = {
				border = "single",
			},
			documentation = {
				auto_show = true,
				window = {
					border = "single",
				},
			},
		}

		-- opts.fuzzy = {
		--   -- Disabling this matches the behavior of fzf
		--   use_typo_resistance = false,
		--   -- Frecency tracks the most recently/frequently used items and boosts the score of the item
		--   use_frecency = true,
		--   -- Proximity bonus boosts the score of items matching nearby words
		--   use_proximity = false,
		-- }

		opts.snippets = {
			preset = "luasnip", -- Choose LuaSnip as the snippet engine
		}

		-- -- To specify the options for snippets
		-- opts.sources.providers.snippets.opts = {
		--   use_show_condition = true, -- Enable filtering of snippets dynamically
		--   show_autosnippets = true, -- Display autosnippets in the completion menu
		-- }

		-- The default preset used by lazyvim accepts completions with enter
		-- I don't like using enter because if on markdown and typing
		-- something, but you want to go to the line below, if you press enter,
		-- the completion will be accepted
		-- https://cmp.saghen.dev/configuration/keymap.html#default
		opts.keymap = {
			preset = "default",
			["<Tab>"] = {
				function(cmp)
					if cmp.snippet_active() then
						return cmp.accept()
					else
						return cmp.select_and_accept()
					end
				end,
				"snippet_forward",
				"fallback",
			},
			["<S-Tab>"] = { "snippet_backward", "fallback" },

			["<Up>"] = { "select_prev", "fallback" },
			["<Down>"] = { "select_next", "fallback" },
			["<C-p>"] = { "select_prev", "fallback" },
			["<C-n>"] = { "select_next", "fallback" },

			["<S-k>"] = { "scroll_documentation_up", "fallback" },
			["<S-j>"] = { "scroll_documentation_down", "fallback" },

			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-e>"] = { "hide", "fallback" },
		}

		return opts
	end,
}
