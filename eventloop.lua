local events = {}
EventLoop = {}
EventLoop.__index = EventLoop

function EventLoop.create(callback, args)
    local event_loop = {}
    setmetatable(event_loop,EventLoop)
    event_loop.callback = callback
    event_loop.is_active = true
    event_loop.args = args
    return event_loop
end

function EventLoop:disable()
   self.is_active = false
end

function EventLoop:enable()
   self.is_active = false
end

function EventLoop:disabled()
   return if(self.is_active ~= true)
end

function EventLoop:enabled()
   return if(self.is_active == true)
end

CreateThread(function()
    while true do
        Wait(0)
        for i = 0,table.getn(events) do
		if(events[i].enabled())
                    events[i].callback(events[i].args)
                end
        end
    end
end)


function addEventLoop(callback, ...)
    local newEventLoopID = table.getn(events) + 1
    events[newEventLoopID] = EventLoop.create(callback, args)
    return newEventLoopID
end

function getEventLoop(id)
    return events[newEventLoopID]
end
