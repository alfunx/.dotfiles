local vim = vim

P = function(v)
    print(vim.inspect(v))
    return v
end

Prequire = function(...)
    local status, lib = pcall(require, ...)
    if (status) then return lib end
    return nil
end
