local M = {}

--[[ tasks.json
{
    // See https://go.microsoft.com/fwlink/?LinkId=733558
    // for the documentation about the tasks.json format
    "version": "2.0.0",
    "tasks": [
        {
            "label": "invoke neovim-build",
            "type": "shell",
            "command": "invoke neovim-build",
            "problemMatcher": []
        }
    ]
}
--]]

M.run = function()
    -- search .vscode/tasks.json
    -- show menu
    print "hello"

    -- run task
end

return M
