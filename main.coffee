WebRcon = require('webrconjs')

ConnectionFactory = require('./lib/connection-factory.coffee')
DiscordEvents = require('./lib/discord-events.coffee')
RustEvents = require('./lib/rust-events.coffee')
Helpers = require('./lib/helpers.coffee')
difference = require('array-difference')

discord = null
helpers = null
debugChannel = null
rustChannel  = null
minecraftPlayers = []
connFactory = new ConnectionFactory()

bootstrap = () ->
  discord = connFactory.getDiscordConnection(process.env.DISCORD_TOKEN)
  

  discord.on 'ready', ->
    console.log('Connected to Discord Server')
    #TODO: channel factory seems applicable
    debugChannel = discord.channels.find('name', 'debug')
    rustChannel = discord.channels.find('name', 'rust-server')
    rust = connFactory.getWrconConnection(process.env.RUST_IP,
                                         process.env.RUST_PORT,
                                         process.env.RUST_PASSWORD)
    
    
    new DiscordEvents(discord)



minecraftRequestLoop = (connFactory) ->
  minecraft = connFactory.getRconConnection(process.env.MINECRAFT_IP,
                                            process.env.MINECRAFT_PORT,
                                            process.env.MINECRAFT_PASSWORD)
  minecraft.exec('list', (res) ->
    
    playerString = res.body.slice(30)
    if playerString.length > 0
      playerList = playerString.trim().split(',')
      diff = difference(playerList.sort(), minecraftPlayers.sort())
      return if playerList.length == minecraftPlayers.length
      else if playerList.length > minecraftPlayers.length
        msg = "Player(s) Joined: #{diff}"
        mcChannel = discord.channels.find('name', 'minecraft-server')
        mcChannel.send(msg)
        console.log msg
      minecraftPlayers = playerList
    ).connect()


setInterval(minecraftRequestLoop , 60000, connFactory)

helpers = new Helpers()
bootstrap()
