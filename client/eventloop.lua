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
   if(self.is_active ~= true) then
       return true
   end 
   return false
end

function EventLoop:enabled()
   if(self.is_active == true) then
       return true
   end 
   return false
end

CreateThread(function()
	-- Loop that runs forever in a separate thread
    while true do
        Wait(0)
        if(table.getn(events) > 0) then
        	-- Loop through all the events
        	for i = 0,(table.getn(events)-1) do
        
        		-- Only execute callbacks in enabled events
				if(events[i].enabled()) then
					-- Execute the callback
           			events[i].callback(events[i].args)
            	end
        	end
        end
    end
end)

function addEventLoop(callback, ...)

	-- Get the table size to generate a new ID
    local newEventLoopID = table.getn(events) + 1
    
  	-- Create a new loop callback with our arguments that are passed to the callback
    events[newEventLoopID] = EventLoop.create(callback, args)
    return newEventLoopID
end

function getEventLoop(id)

	-- Returns EventLoop object at position `id`
    return events[id]
end

export 'eventLoop'