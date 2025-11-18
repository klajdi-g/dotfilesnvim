local mason_ok, mason = pcall(require, "mason")
if not mason_ok then
	vim.notify("mason not available", vim.log.levels.ERROR)
	return
end
mason.setup()

local mlsp_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mlsp_ok then
	vim.notify("mason-lspconfig not available", vim.log.levels.ERROR)
	return
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
if cmp_ok then
	capabilities = cmp_lsp.default_capabilities(capabilities)
end

local lspcfg = vim.lsp.config

local function safe_setup(server_name, opts)
	opts = opts or {}
	opts.capabilities = capabilities

	local cfg = lspcfg[server_name]
	if not cfg or type(cfg.setup) ~= "function" then
		vim.notify("LSP not registered in vim.lsp.config: " .. server_name, vim.log.levels.WARN)
		return
	end

	cfg.setup(opts)
end

mason_lspconfig.setup({
	ensure_installed = {
		"ts_ls",
		"eslint",
		"vue_ls", -- new name instead of volar
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
		-- default handler for all servers
		function(server_name)
			safe_setup(server_name)
		end,

		-- lua_ls with extra settings
		["lua_ls"] = function()
			safe_setup("lua_ls", {
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
					},
				},
			})
		end,
	},
})

local conform_ok, conform = pcall(require, "conform")
if not conform_ok then
	return
end

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
