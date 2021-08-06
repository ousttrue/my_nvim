local M = {}

M.close = function()
    local b = vim.fn.bufname "%"
    vim.cmd "bn"
    local next = vim.fn.bufname "%"
    if next == b then
        vim.cmd "enew"
    end
    vim.cmd(string.format("bdel %s", b))
end

return M
