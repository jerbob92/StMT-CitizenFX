description 'Steal the Money Truck Gamemode'

resource_type 'gametype' { name = 'StMT' }

dependencies {
    "spawnmanager",
    "mapmanager"
}

client_scripts {
    'client/eventloop.lua',
    'client/pickuphelper.lua',
    'client/stmt_client.lua'
}

server_script 'server/stmt_server.lua'
