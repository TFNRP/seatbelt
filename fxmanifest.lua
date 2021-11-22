fx_version 'cerulean'
game 'gta5'

repository 'https://github.com/TFNRP/seatbelt'
fork_repository 'https://github.com/TehRamsus/Seatbelt'
version '1.0.0'
author 'Reece Stokes <hagen@hyena.gay>'

client_script {
  '@framework/util.lua',
  'config.lua',
  'util.lua',
  'client.lua',
}
server_script 'server.lua'
ui_page 'static/index.html'
file 'static/*'