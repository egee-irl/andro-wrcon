connFactory = null
# minecraft = null
helpers = null

class DiscordEvents
  constructor: (discord, helpers, connFactory) ->

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
    discord.on 'message', (message) ->
      switch true
        when message.content.includes '~minecraft list'
        then helpers.minecraftList(connFactory)


module.exports = DiscordEvents