--
-- lsp
--
local cmd = { "rust-analyzer" }
if vim.fn.has("win32") ~= 0 then
	cmd = {
		vim.env.APPDATA
			.. "\\Code\\User\\globalStorage\\matklad.rust-analyzer\\rust-analyzer-x86_64-pc-windows-msvc.exe",
	}
end
require("lspconfig").rust_analyzer.setup({
	cmd = cmd,
	on_attach = function(_, bufnr)
		require("lsp_on_attach")(_, bufnr)

		local opts = { noremap = true, silent = true }
		-- vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-S-b>", ":T cargo build<CR>", opts)
	end,
	settings = {
		["rust-analyzer"] = {
			assist = {
				importGranularity = "module",
				importPrefix = "by_self",
			},
			cargo = {
				loadOutDirsFromCheck = true,
			},
			procMacro = {
				enable = true,
			},
		},
	},
})

--
-- dap
--
local exe = ""
if vim.fn.has("win32") ~= 0 then
	exe = vim.env.USERPROFILE .. "/.vscode/extensions/vadimcn.vscode-lldb-1.6.5/adapter/codelldb.exe"
else
	exe = "/usr/bin/codelldb"
end

local function split(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t = {}
	for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
		table.insert(t, str)
	end
	return t
end

local dap = require("dap")
dap.adapters.codelldb = {
	type = "executable_server",
	command = exe,
}
dap.configurations.rust = {
	{
		name = "Launch",
		type = "codelldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", dap.get_workspaceFolder() .. "/target/debug/", "file")
		end,
		args = function()
			return { dap.get_workspaceFolder():joinpath("assets").filename }
		end,
		cwd = function()
			return dap.get_workspaceFolder().filename
		end,
		stopOnEntry = false,
		-- env = {
		-- 	RUST_BACKTRACE = 1,
		-- },
	},
}
