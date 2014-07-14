local pickups = {}

Pickup = {}
Pickup.__index = Pickup

function Pickup.create(callback, pickup, blip, args)
    local pickup = {}
    setmetatable(pickup,Pickup)
    pickup.callback = callback
    pickup.pickup = pickup
    pickup.blip = blip
    pickup.args = args
    pickup.picked_up = false
    return pickup
end

function checkOnCollectedPickup()

	if(table.getn(pickups) > 0) then
		-- Loop through all defined pickups
		for i = 0,(table.getn(pickups)-1) do
			-- Check if: pickup isn't picked up yet, if it exists and if the player picked it up
			-- Maybe pickups[i].picked_up should be last, but I think it's the fastest call in this if
			if(pickups[i].picked_up == false and DoesPickupExist(pickups[i].pickup) and HasPlayerCollectedPickup(GetPlayerId(_r), pickups[i].pickup)) then

				-- Set our pickup to picked up
				pickups[i].picked_up = true
			
				-- Execute the callback of this if
				pickups[i].callback(pickups[i].args)
			
				-- Remove our pickup from the game
				RemovePickup(hospitalPickups[i].pickup)
			end
    	end
    end
end

function createPickup(model, type, blipIcon, x, y, z, onPickupCallback, ...)

	-- Get the table size to get our new ID
    local pickupId = table.getn(pickups)+1

    -- Create a new model of our model and type at our location
    local pickup = CreatePickup(model, type, x, y, z, _i, false)
    
    -- Add blip on position
    local blip = AddBlipForCoord(x, y, z, _i);
    
    -- Change blip to requested sprite
    ChangeBlipSprite(blip, blipIcon)
    
    -- Insert our pickup in the pickup table and return the ID
	pickups[pickupId] = Pickup.create(onPickupCallback, pickup, blip, args) 
	return pickupId
end

AddEventHandler('createPickupLoop', function()
    -- Add our pickup check to the global eventloop
	local eventId = exports.stmt:eventLoop.addEventLoop(checkOnCollectedPickup)
end)

export 'pickupHelper'