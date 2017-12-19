DiscordJs = require('discord.js')
WebRcon = require('webrconjs')

DiscordEvents = require('./lib/discord-events.coffee')
RustEvents = require('./lib/rust-events.coffee')
Helpers = require('./lib/helpers.coffee')

discord = null
helpers = null
debugChannel = null
rustChannel  = null

bootStrap = (token) ->
  discord = new DiscordJs.Client()
  discord.login(token)
  .catch(console.error)
  discord.on 'ready', ->
    console.log('Connected to Discord Server')
    debugChannel = discord.channels.find('name', 'debug')
    rustChannel = discord.channels.find('name', 'rust-server')
    wRcon(process.env.RUST_IP, process.env.RUST_PORT, process.env.RUST_PASSWORD)
    new DiscordEvents(discord)

wRcon = (rustip, rustport, password) ->
  wRcon = new WebRcon(rustip, rustport)
  wRcon.connect(password)
  new RustEvents(wRcon, helpers, discord)

helpers = new Helpers()
bootStrap(process.env.DISCORD_TOKEN)
