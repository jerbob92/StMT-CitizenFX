RegisterServerEvent('playerActivated')

AddEventHandler('playerActivated', function()
	TriggerClientEvent('createPickupLoop', source)
    TriggerClientEvent('createHospitalPickup', source)
end)
