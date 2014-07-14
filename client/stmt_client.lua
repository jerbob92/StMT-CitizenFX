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

CreateThread(function()
	CreateHospital(1246.63806, 485.62134, 29.53984, 10)
end)