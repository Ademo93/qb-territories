fx_version 'cerulean'
game 'gta5'


shared_scripts { 
	'shared/*.lua',
	'@qb-core/shared/locale.lua',
	'locales/en.lua', --change language here
}

client_scripts {
	'@PolyZone/client.lua',
	'@PolyZone/CircleZone.lua',
	'client/main.lua'
}

server_scripts {
	'server/main.lua'
}



