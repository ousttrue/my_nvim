local pid = vim.fn.getpid()
-- On linux/darwin if using a release build, otherwise under scripts/OmniSharp(.Core)(.cmd)
local omnisharp_bin = vim.env.USERPROFILE
	.. "/.vscode/extensions/ms-dotnettools.csharp-1.23.12/.omnisharp/1.37.10/OmniSharp.exe"
-- on Windows
-- local omnisharp_bin = "/path/to/omnisharp/OmniSharp.exe"
require("lspconfig").omnisharp.setup({
	cmd = { omnisharp_bin, "--languageserver", "--hostPID", tostring(pid) },
	...,
})

local dap = require("dap")
dap.adapters.netcoredb = {
	type = "executable",
	command = vim.env.USERPROFILE .. "/Desktop/netcoredbg/netcoredbg.exe",
	args = { "--interpreter=vscode" },
}
dap.adapters.unity = {
	type = "executable",
	command = vim.env.USERPROFILE .. "/.vscode/extensions/unity.unity-debug-2.7.5/bin/UnityDebug.exe",
}
dap.configurations.cs = {
	{
		name = "Launch",
		type = "netcoredb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
		end,
	},
	{
		name = "Attach Unity",
		type = "unity",
		request = "launch",
		program = function()
			return vim.fn.input("Path to EditorInstance.json", vim.fn.getcwd(), "file")
		end,
	},
}
