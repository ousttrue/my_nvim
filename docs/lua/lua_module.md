# string

https://www.lua.org/manual/5.1/manual.html#5.4

# table

## debug

```lua
-- get callstack
local file = debug.getinfo(1, "S").source:sub(2)
```

