pickupHelper = {}
local pickups = {}

Pickup = {}
Pickup.__index = Pickup

function Pickup.create(callback, collectable_pickup, blip, callback_arg)
    local pickup = {}
    setmetatable(pickup,Pickup)
    pickup.callback = callback
    pickup.pickup = collectable_pickup
    pickup.blip = blip
    pickup.arg = callback_arg
    pickup.picked_up = false
    return pickup
end

function checkOnCollectedPickup()
	-- Loop through all defined pickups
	for i, pickup in ipairs(pickups) do
		-- Check if: pickup isn't picked up yet, if it exists and if the player picked it up
		-- Maybe pickups[i].picked_up should be last, but I think it's the fastest call in this if
		if(pickup.picked_up == false and DoesPickupExist(pickup.pickup) and HasPlayerCollectedPickup(GetPlayerId(_r), pickup.pickup)) then

			-- Set our pickup to picked up
			pickup.picked_up = true

			-- Remove our pickup from the game
			RemovePickup(pickup.pickup)
			
			-- Remove our blip from the game
			RemoveBlip(pickup.blip)
			
			-- Execute the callback of this callback
			pickup.callback(pickup.arg)
		end
   	end
end

function pickupHelper.pack(...)
  local n = select('#', ...)
  local t = {}
  for i = 1,n do
    local v = select(i, ...)
    t[i] = (v == nil) and NIL or v
  end
  return t
end

function pickupHelper.createPickup(model, type, blipIcon, x, y, z, onPickupCallback, ...)

	local arg = pickupHelper.pack(...)

	-- Get the table size to get our new ID
    local pickupId = table.getn(pickups) + 1

    -- Create a new model of our model and type at our location
    local pickup = CreatePickup(model, type, x, y, z, _i, false)
    
    -- Add blip on position
    local blip = AddBlipForCoord(x, y, z, _i);
    
    -- Change blip to requested sprite
    ChangeBlipSprite(blip, blipIcon)
    
    -- Insert our pickup in the pickup table and return the ID
	local newPickup = Pickup.create(onPickupCallback, pickup, blip, arg) 
	table.insert(pickups, pickupId, newPickup)
	return pickupId
end

local eventId = eventLoop.addEventLoop(checkOnCollectedPickup)
