fx_version 'cerulean'
game 'gta5'
author 'Barikelo & Juliroo | REDESIGNED BY FXDOPA'
version '2.0'
description 'Re-Design of bk_emotes by FXDOPA | Improved with a lot of features'

client_scripts {
	'Config.lua',
 	'Client/*.lua'
}

server_scripts {
	'Config.lua',
	'Server/*.lua'
}

export {
    'WalkMenuStart'
}
ui_page {
 'Client/html/index.html', 
}
files {
 'Client/html/index.html',
 'Client/html/app.js', 
 'Client/html/main.css',
 'Client/html/ios.ttf',
 'Client/html/search.svg'
}