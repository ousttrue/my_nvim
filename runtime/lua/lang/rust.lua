require("lspconfig").rust_analyzer.setup({
	on_attach = require("lsp_on_attach"),
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
		args = { "assets" },
		cwd = function()
			return dap.get_workspaceFolder().filename
		end,
		stopOnEntry = false,
	},
}
