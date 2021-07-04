local pid = vim.fn.getpid()
-- On linux/darwin if using a release build, otherwise under scripts/OmniSharp(.Core)(.cmd)

local omnisharp_bin = ""
local netcoredbg = ""
local unity = ""
if vim.fn.has("win32") ~= 0 then
	omnisharp_bin = vim.env.USERPROFILE
		.. "/.vscode/extensions/ms-dotnettools.csharp-1.23.12/.omnisharp/1.37.10/OmniSharp.exe"
	netcoredbg = vim.env.USERPROFILE .. "/Desktop/netcoredbg/netcoredbg.exe"
	unity = vim.env.USERPROFILE .. "/.vscode/extensions/unity.unity-debug-2.7.5/bin/UnityDebug.exe"
else
	omnisharp_bin = "/usr/bin/OmniSharp"
	netcoredbg = "/usr/bin/netcoredbg"
	unity = "/usr/bin/UnityDebug"
end

-- on Windows
-- local omnisharp_bin = "/path/to/omnisharp/OmniSharp.exe"
require("lspconfig").omnisharp.setup({
	cmd = { omnisharp_bin, "--languageserver", "--hostPID", tostring(pid) },
	...,
})

local dap = require("dap")
dap.adapters.netcoredbg = {
	type = "executable",
	command = netcoredbg,
	args = { "--interpreter=vscode" },
}
dap.adapters.unity = {
	type = "executable",
	command = unity,
}
dap.configurations.cs = {
	{
		name = "Launch",
		type = "netcoredbg",
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
