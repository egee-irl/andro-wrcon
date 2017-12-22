WebRcon = require('webrconjs')
Rcon = require('simple-rcon')
DiscordJs = require('discord.js')

class ConnectionFactory
  getDiscordConnection: (token) ->
    discord = new DiscordJs.Client()
    discord.login(token)
    .catch(console.error) #TODO: Stop the process when error is caught
    return discord
  getWrconConnection: (ip, port, password) ->
    wRcon = new WebRcon(ip, port)
    wRcon.connect(password)
    return wRcon
  getRconConnection: (ip, port, password) ->
    return new Rcon({host: ip, port: port, password: password})

module.exports = ConnectionFactory