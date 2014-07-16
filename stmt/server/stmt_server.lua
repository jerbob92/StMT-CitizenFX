RegisterServerEvent('savePos')
AddEventHandler('savePos', function(name, x, y, z, carheading)
	local f,err = io.open("pos.txt","a")
	if not f then return print(err) end
	f:write(name .. ": { " .. x .. ", " .. y .. ", " .. z .. ", heading = ".. carheading .. " }\n")
	f:close()
end)

AddEventHandler('onGameTypeStart', function(resource)
    print("omg, we're running!")
end)

AddEventHandler('onMapStart', function(resource)
    print("omg, map start!")
end)