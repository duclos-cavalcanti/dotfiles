local Node = {}
Node.__index = Node

function Node:new(key, data)
    data = data or {}

    return setmetatable({
            next = nil,
            key = key,
            data = data,
        }, self)
end

local Stack = {}
Stack.__index = Stack

function Stack:new(opts)
    return setmetatable({
        size = 0,
        head = nil,
        }, self)
end

function Stack:empty()
    return self.head == nil
end

function Stack:push(key, data)
    local node = Node:new(key, data)

    if not self.head then
        self.head = node
    else
        local nxt = self.head
        self.head = node
        self.head.next = nxt
    end

    self.size = self.size + 1
end

function Stack:pop()
    if self:empty() then
        return nil
    end

    local elem = self.head
    self.head = self.head.next

    self.size = self.size - 1
    return elem
end

function Stack:top()
    local elem = self.head
    return elem
end

function Stack:getSize()
    local size = self.size
    return size
end

function Stack:iter()
    local current_node = self.head

    return function()
        local node = current_node
        if not node then
            return nil
        end

        current_node = current_node.next
        return node
    end
end

return Stack
