function HospitalPickup(args)
	-- args is what's passed with the callback
	TriggerEvent('chatMessage', 'Hospital', { 0, 0x99, 255 }, "You get some health from the hospital." .. print(args))
	SetCharHealth(GetPlayerPed(), 200)
end

function CreateHospital(x, y, z, health)
	-- model, type, blip, x, y, z, callback, callback arguments (...)
	exports.stmt:pickupHelper.createPickup(0x3675A6C3, 23, 62, x, y, z, HospitalPickup, health)
end


AddEventHandler('createHospitalPickup', function()
    -- x, y, z, health
	CreateHospital(1246.63806, 485.62134, 29.53984, 200)
end)
