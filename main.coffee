WebRcon = require("webrconjs")
DiscordJs = require('discord.js')

discord = new DiscordJs.Client()
discord.login(process.env.PYGUY)

debugChannel = ""
rustChannel  = ""
reoccuringErrors = 0

discord.on "ready", ->
  debugChannel = discord.channels.find("name", "debug")
  rustChannel = discord.channels.find("name", "rust-server")
  wRcon(process.env.RUST_IP, process.env.RUST_PORT, process.env.RUST_PASSWORD)

errorNotification = (error) ->
  process.exit(1) if reoccuringErrors > 10
  console.log(error)
  debugChannel.send(error)
  .then(reoccuringErrors++)

wRcon = (rustip, rustport, password) ->
  wRcon = new WebRcon(rustip, rustport)
  wRcon.connect(password)
  wRcon.on "connect", -> console.log "Connected!"
  wRcon.on "disconnect", -> errorNotification("wRcon was disconnected")
  wRcon.on "error", (err) -> errorNotification("wRcon #{err}")
  wRcon.on "message", (msg) ->
    if msg.message.includes("has entered the game")
      playerJoin = msg.message.replace(/\[.*\]/, "")
      rustChannel.fetchMessage(rustChannel.lastMessageID)
      .then (message) ->
        if playerJoin != message.content
          rustChannel.send(playerJoin)
          rustJoin = playerJoin.replace("entered", "joined")
          wRcon.run("say " + rustJoin, 0)
      .catch ((error) -> errorNotification(error))
    else console.log(msg.message)
