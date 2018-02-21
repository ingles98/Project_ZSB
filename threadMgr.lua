--All threads are called in MAIN ONLY. This file is only for global channels and thread creation.
thread = {}
thread.worldThread = love.thread.newThread('worldThread.lua')

channel = {}
channel.mTw = love.thread.getChannel('mTw')
channel.wTm = love.thread.getChannel('wTm')

function threadMgrUpdate()  --only called in MAIN
    for k,v in pairs(thread) do
        local err = v:getError()
        if err then print(err) thread[k] = nil end
    end


end
