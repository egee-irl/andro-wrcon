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

module.exports = Helpers
