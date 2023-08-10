
P = function(v)
    print(vim.inspect(v))
    return v
end

R = function(name)
    require(name)
    return require(name)
end
