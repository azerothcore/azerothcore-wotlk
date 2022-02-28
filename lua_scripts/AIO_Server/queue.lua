local Queue = {}
function Queue.__index(que, key)
    return Queue[key]
end

function NewQueue()
    local t = {first = 0, last = -1}
    setmetatable(t, Queue)
    return t
end

function Queue.pushleft(que, value)
    local first = que.first - 1
    que.first = first
    que[first] = value
    return first
end

function Queue.pushright(que, value)
    local last = que.last + 1
    que.last = last
    que[last] = value
    return last
end

function Queue.popleft(que)
    local first = que.first
    if first > que.last then error("que is empty") end
    local value = que[first]
    que[first] = nil        -- to allow garbage collection
    que.first = first + 1
    return value
end

function Queue.popright(que)
    local last = que.last
    if que.first > last then error("que is empty") end
    local value = que[last]
    que[last] = nil         -- to allow garbage collection
    que.last = last - 1
    return value
end

function Queue.peekleft(que)
    return que[que.first]
end

function Queue.peekright(que)
    return que[que.last]
end

function Queue.empty(que)
    return que.last < que.first
end

function Queue.size(que)
    return que.last - que.first + 1
end

function Queue.clear(que)
    local l, r = self:getrange()
    for i = l, r do
        que[idx] = nil
    end
    que.first, que.last = 0, -1
end

function Queue.get(que, idx)
    if idx < que.first or idx > que.last then
        return
    end
    return que[idx]
end

function Queue.getrange(que)
    return que.first, que.last
end

function Queue.gettable(que)
    return que
end

return NewQueue
