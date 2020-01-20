Rcon = require('simple-rcon')
DiscordJs = require('discord.js')

class ConnectionFactory
  getDiscordConnection: (token) ->
    discord = new DiscordJs.Client()
    discord.login(token)
    .catch(console.error) #TODO: Stop the process when error is caught
    return discord

  getRconConnection: (ip, port, password) ->
    return new Rcon({host: ip, port: port, password: password})

module.exports = ConnectionFactory