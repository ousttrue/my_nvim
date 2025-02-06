# null-ls

`archived` https://github.com/jose-elias-alvarez/null-ls.nvim

## none-ls

https://github.com/nvimtools/none-ls.nvim

- @2023 [とりあえずnone-ls.nvimでよくないか？ / null-ls.nvimの保守的代替 | 点と接線。](https://riq0h.jp/2023/11/05/085628/)
- @2023 [NeoVim - null-lsの代替となるか？none-lsについて](https://zenn.dev/yutti/articles/7baeec34836bc5)


```lua
---@param root_dir string? The root directory of the project.
M.start_client = function(root_dir)
    local config = {
        name = "null-ls",
        root_dir = root_dir,
        on_init = on_init,
        on_exit = on_exit,
        cmd = require("null-ls.rpc").start, -- pass callback to create rpc client
        filetypes = require("null-ls.sources").get_filetypes(),
        flags = { debounce_text_changes = c.get().debounce },
        on_attach = vim.schedule_wrap(function(_, bufnr)
            if bufnr == api.nvim_get_current_buf() then
                M.setup_buffer(bufnr)
            elseif api.nvim_buf_is_valid(bufnr) then
                api.nvim_create_autocmd("BufEnter", {
                    buffer = bufnr,
                    once = true,
                    callback = function()
                        M.setup_buffer(bufnr)
                    end,
                })
            end
        end),
    }

    log:trace("starting null-ls client")
    id = lsp.start_client(config)
```

vim.lsp.rpc.PublicClient

`require("null-ls.rpc").start`
```lua
---@param dispatchers vim.lsp.rpc.Dispatchers
---@return vim.lsp.rpc.PublicClient
M.start = function(dispatchers)
    local message_id = 1
    local stopped = false

    ---@param method vim.lsp.protocol.Method|string LSP method name.
    ---@param params table? LSP request params.
    ---@param callback fun(err: lsp.ResponseError|nil, result: any)?
    ---@param is_notify boolean?
    local function handle(method, params, callback, is_notify)
        params = params or {}
        callback = callback and vim.schedule_wrap(callback)
        message_id = message_id + 1

        if type(params) ~= "table" then
            params = { params }
        end

        params.method = method
        params.client_id = require("null-ls.client").get_id()

        local send = function(result)
            if callback then
                callback(nil, result)
            end
        end

        if method == methods.lsp.INITIALIZE then
            send({ capabilities = capabilities })
        elseif method == methods.lsp.SHUTDOWN then
            stopped = true
            send()
        elseif method == methods.lsp.EXIT then
            if dispatchers.on_exit then
                dispatchers.on_exit(0, 0)
            end
        else
            if is_notify then
                require("null-ls.diagnostics").handler(params)
            end
            require("null-ls.code-actions").handler(method, params, send)
            require("null-ls.formatting").handler(method, params, send)
            require("null-ls.hover").handler(method, params, send)
            require("null-ls.completion").handler(method, params, send)
            if not params._null_ls_handled then
                send()
            end
        end

        return true, message_id
    end

    ---@param method vim.lsp.protocol.Method|string LSP method name.
    ---@param params table? LSP request params.
    ---@param callback fun(err: lsp.ResponseError|nil, result: any)
    ---@param notify_callback fun(message_id: integer)?
    local function request(method, params, callback, notify_callback)
        log:trace("received LSP request for method " .. method)

        -- clear pending requests from client object
        local success = handle(method, params, callback)
        if success and notify_callback then
            -- copy before scheduling to make sure it hasn't changed
            local id_to_clear = message_id
            vim.schedule(function()
                notify_callback(id_to_clear)
            end)
        end

        return success, message_id
    end

    ---@param method string LSP method name.
    ---@param params table? LSP request params.
    local function notify(method, params)
        if should_cache(method) then
            set_cache(params)
            return
        end

        if method == methods.lsp.DID_CLOSE then
            clear_cache(params)
        end

        log:trace("received LSP notification for method " .. method)
        return handle(method, params, nil, true)
    end

    return {
        request = request,
        notify = notify,
        is_closing = function()
            return stopped
        end,
        terminate = function()
            cache._reset()
            stopped = true
        end,
    }
end
```
