class Helpers
  reoccuringErrors = 0
  discord = null
  constructor: (Discord) ->
    discord = Discord
  errorNotification: (error, channel) ->
    process.exit(1) if reoccuringErrors > 10
    console.log(error)
    channel.send(error)
    .then(reoccuringErrors++)
  discordChannel: (channel) ->
    discord.channels.find('name', channel)
  minecraftList: (connFactory) ->
    minecraft = connFactory.getRconConnection(process.env.MINECRAFT_IP,
                                          process.env.MINECRAFT_PORT,
                                          process.env.MINECRAFT_PASSWORD)
    minecraft.exec('list', (res) ->
      playerList = res.body
      debugChannel = discord.channels.find('name', 'debug')
      debugChannel.send(res.body)).connect()
    minecraft.on('error', (err) ->
      console.log "something in the MC loop shit out: #{err}")


module.exports = Helpers
