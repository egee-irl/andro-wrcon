WebRcon = require('webrconjs')

ConnectionFactory = require('./lib/connection-factory.coffee')
DiscordEvents = require('./lib/discord-events.coffee')
RustEvents = require('./lib/rust-events.coffee')
Helpers = require('./lib/helpers.coffee')

discord = null
helpers = null
debugChannel = null
rustChannel  = null

bootstrap = () ->
  connFactory = new ConnectionFactory()
  discord = connFactory.getDiscordConnection(process.env.RBBY)

  discord.on 'ready', ->
    console.log('Connected to Discord Server')
    #TODO: channel factory seems applicable
    debugChannel = discord.channels.find('name', 'debug')
    rustChannel = discord.channels.find('name', 'rust-server')
    rust = connFactory.getRustConnection(process.env.RUST_IP,
                                         process.env.RUST_PORT,
                                         process.env.RUST_PASSWORD)
    new DiscordEvents(discord)

helpers = new Helpers()
bootstrap()
