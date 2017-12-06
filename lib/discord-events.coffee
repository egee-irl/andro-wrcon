class DiscordEvents
  constructor: (discord) ->
    generalChannel = discord.channels.find('name', 'generalChannel')
    discord.on "guildMemberAdd", (member) ->
      msg = "**#{member.displayName}**  has joined the server! 👋"
      generalChannel.send(msg)
      .then(console.log(msg))
      .catch(console.error)

module.exports = DiscordEvents