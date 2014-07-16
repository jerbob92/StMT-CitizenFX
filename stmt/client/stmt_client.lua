function HospitalPickup(arg)
	-- args is what's passed with the callback
	TriggerEvent('chatMessage', 'Hospital', { 0, 0x99, 255 }, "You get " .. arg[1] .. " health from the hospital." )
	local curHealth = GetCharHealth(GetPlayerPed());
	SetCharHealth(GetPlayerPed(), (curHealth + arg[1]))
end

function CreateHospital(x, y, z, health)
	-- model, type, blip, x, y, z, callback, callback arguments (...)
	pickupHelper.createPickup(0x3675A6C3, 23, 62, x, y, z, HospitalPickup, health)
end

function csplit(str,sep)
        local ret={}
        local n=1
        for w in str:gmatch("([^"..sep.."]*)") do
                        ret[n]=ret[n] or w -- only set once (so the blank after a string is ignored)
                        if w=="" then n=n+1 end -- step forwards on a blank but not a string
        end
        return ret
end

CreateThread(function()
	CreateHospital(1246.63806, 485.62134, 29.53984, 10)
end)

function round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end

AddEventHandler('onClientMapStart', function()
    exports.spawnmanager:setAutoSpawn(true)
    exports.spawnmanager:forceRespawn()
end)

AddEventHandler('chatMessage', function(name, color, message)
	if(string.sub(message, 0, 8)  == '/savepos') then
		local name = ''
		if(string.len(message) > 9) then
			name = string.sub(message, 10)
		end
		pos = table.pack(GetCharCoordinates(GetPlayerPed(), _f, _f, _f))
		
		local car = GetCarCharIsUsing(GetPlayerPed(), _f)
		local carheading = 0
		if(car) then
			carheading = GetCarHeading(car, _f)	
		end
		
		echo(tostring(carheading))
		
		TriggerServerEvent('savePos', name, round(pos[1], 5), round(pos[2], 5), round(pos[3], 5), round(carheading, 5))
	end
end)

