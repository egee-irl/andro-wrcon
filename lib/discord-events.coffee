generalChannel = null

class DiscordEvents
  constructor: (discord) ->

    generalChannel = discord.channels.find('name', 'general')
    debugChannel = discord.channels.find('name', 'debug')

    discord.on "guildMemberAdd", (member) ->
      msg = "**#{member.displayName}**  has joined the server! 👋"
      generalChannel.send(msg)
      .then(console.log(msg))
      .catch(console.error)
    discord.on "guildMemberRemove", (member) ->
      msg = "**#{member.displayName}**  has left the server 🖕"
      debugChannel.send(msg)
      .then(console.log(msg))
      .catch(console.error)

module.exports = DiscordEvents