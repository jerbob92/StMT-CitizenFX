eventLoop = {}

local events = {}
EventLoop = {}
EventLoop.__index = EventLoop

function EventLoop.create(callback, callback_args)
    local event_loop = {}
    setmetatable(event_loop,EventLoop)
    event_loop.callback = callback
    event_loop.is_active = true
    event_loop.arg = callback_args
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
        -- Loop through all the events
       	for i, event in ipairs(events) do
        	-- Only execute callbacks in enabled events
			if(event:enabled()) then
				-- Execute the callback
        		event.callback(events[i].arg)
           	end
        end
    end
end)

function eventLoop.pack(...)
  local n = select('#', ...)
  local t = {}
  for i = 1,n do
    local v = select(i, ...)
    t[i] = (v == nil) and NIL or v
  end
  return t
end

function eventLoop.addEventLoop(callback, ...)

	local arg = eventLoop.pack(...)

	-- Get the table size to generate a new ID
    local newEventLoopID = table.getn(events) + 1
    
  	-- Create a new loop callback with our arguments that are passed to the callback
  	local event_loop = EventLoop.create(callback, arg);
    table.insert(events, newEventLoopID, event_loop)
    return newEventLoopID
end

function eventLoop.getEventLoop(id)

	-- Returns EventLoop object at position `id`
    return events[id]
end