ConnectionFactory = require('./lib/connection-factory.coffee')
DiscordEvents = require('./lib/discord-events.coffee')
RustEvents = require('./lib/rust-events.coffee')
Helpers = require('./lib/helpers.coffee')
difference = require('array-difference')

discord = null
helpers = null
minecraftPlayers = []
connFactory = new ConnectionFactory()

bootstrap = () ->
  discord = connFactory.getDiscordConnection(process.env.DISCORD_TOKEN)
  discord.on 'ready', ->
    console.log('Connected to Discord Server')
    helpers = new Helpers(discord)
    rust = connFactory.getWrconConnection(process.env.RUST_IP,
                                          process.env.RUST_PORT,
                                          process.env.RUST_PASSWORD)
    new RustEvents(rust, helpers)
    new DiscordEvents(discord)

minecraftRequestLoop = (connFactory) ->
  minecraft = connFactory.getRconConnection(process.env.MINECRAFT_IP,
                                            process.env.MINECRAFT_PORT,
                                            process.env.MINECRAFT_PASSWORD)
  minecraft.exec('list', (res) ->
    playerString = res.body.slice(30)
    if playerString.length > 0
      playerList = playerString.split(',')
      diff = difference(minecraftPlayers.sort(), playerList.sort())
      if playerList.length > minecraftPlayers.length
        msg = "Player(s) Joined: #{diff}"
        mcChannel = helpers.discordChannel('debug')
        mcChannel.send(msg)
        console.log msg
      minecraftPlayers = playerList
    ).connect()
  minecraft.on('error', (err) ->
    console.log "something in the MC loop shit out: #{err}")

setInterval(minecraftRequestLoop , 60000, connFactory)

bootstrap()
