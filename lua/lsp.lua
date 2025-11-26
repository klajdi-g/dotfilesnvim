-- Mason
local mason_ok, mason = pcall(require, "mason")
if not mason_ok then
	return
end
mason.setup()

local mlsp_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mlsp_ok then
	return
end

-- Capabilities for auto-imports in completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
if cmp_ok then
	capabilities = cmp_lsp.default_capabilities(capabilities)
end

local lspcfg = vim.lsp.config

local function safe_setup(server, opts)
	opts = opts or {}
	opts.capabilities = capabilities

	local cfg = lspcfg[server]
	if not cfg or type(cfg.setup) ~= "function" then
		vim.notify("LSP not found: " .. server, vim.log.levels.WARN)
		return
	end

	cfg.setup(opts)
end

mason_lspconfig.setup({
	ensure_installed = {
		"ts_ls",
		"eslint",
		"vue_ls",
		"intelephense",
		"clangd",
		"omnisharp",
		"hls",
		"lua_ls",
		"html",
		"cssls",
		"jsonls",
		"yamlls",
	},
	handlers = {
		-- default
		function(server)
			safe_setup(server)
		end,

		-- Lua
		["lua_ls"] = function()
			safe_setup("lua_ls", {
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
					},
				},
			})
		end,

		-- TypeScript / JavaScript
		["ts_ls"] = function()
			safe_setup("ts_ls", {
				settings = {
					typescript = {
						inlayHints = { includeInlayParameterNameHints = "all" },
						preferences = {
							importModuleSpecifierPreference = "relative",
							quotePreference = "double",
						},
					},
					javascript = {
						preferences = {
							importModuleSpecifierPreference = "relative",
							quotePreference = "double",
						},
					},
				},
			})
		end,

		-- Vue
		["vue_ls"] = function()
			safe_setup("vue_ls", {
				settings = {
					vue = {
						autoComplete = true,
						suggest = { autoImports = true },
					},
				},
			})
		end,

		-- PHP
		["intelephense"] = function()
			safe_setup("intelephense", {
				settings = {
					intelephense = {
						completion = {
							fullyQualifyGlobalConstantsAndFunctions = true,
						},
					},
				},
			})
		end,

		-- C#
		["omnisharp"] = function()
			safe_setup("omnisharp", {
				enable_import_completion = true,
			})
		end,
	},
})

-- Conform formatting
local conform_ok, conform = pcall(require, "conform")
if conform_ok then
	conform.setup({
		formatters_by_ft = {
			javascript = { "prettier" },
			typescript = { "prettier" },
			javascriptreact = { "prettier" },
			typescriptreact = { "prettier" },
			vue = { "prettier" },
			css = { "prettier" },
			html = { "prettier" },
			json = { "prettier" },
			yaml = { "prettier" },

			lua = { "stylua" },
			php = { "php_cs_fixer" },
			c = { "clang_format" },
			cpp = { "clang_format" },
			cs = { "csharpier" },
			haskell = { "hindent" },
		},
		format_on_save = {
			timeout_ms = 800,
			lsp_fallback = true,
		},
	})

	vim.keymap.set("n", "<leader>fm", function()
		conform.format()
	end, { desc = "Format file" })
end

-- Code Action (auto-import shortcut)
vim.keymap.set("n", "<leader>.", vim.lsp.buf.code_action, { desc = "Code Actions (imports)" })
vim.keymap.set("n", "<C-.>", vim.lsp.buf.code_action, { desc = "VSCode-style Code Actions" })
