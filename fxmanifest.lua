fx_version 'cerulean'
game 'gta5'

lua54 'yes'

author 'MEKEZ'
description 'Carkey with prop'
version '1.0.0'

shared_script {
    '@es_extended/imports.lua',
    'config.lua'
}

client_scripts {
    'client.lua'
}

dependencies {
    'oxmysql',  -- Ensure oxmysql is a dependency
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',  -- Ensure oxmysql is included
    'server.lua',
}
