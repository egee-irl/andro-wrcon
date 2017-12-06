class DiscordEvents
  constructor: (discord) ->
    generalChannel = discord.channels.find('name', 'generalChannel')
    discord.on "guildMemberAdd", (member) ->
<<<<<<< HEAD
      msg = "**#{member.displayName}**  has joined the server! 👋"
=======
      msg = "**#{member.displayName }**  has joined the server! 👋"
>>>>>>> d46ec9625134f00f3f8c4f78b9aacfc869d383af
      generalChannel.send(msg)
      .then(console.log(msg))
      .catch(console.error)

module.exports = DiscordEvents