DiscordJs = require('discord.js')
WebRcon = require("webrconjs")
reoccuringErrors = 0
debugChannel = ""
rustChannel  = ""

errorNotification = (error) ->
  process.exit(1) if reoccuringErrors > 10
  console.log(error)
  debugChannel.send(error)
  .then(reoccuringErrors++)

discordClient = (token) ->
  discord = new DiscordJs.Client()
  discord.login(token)
  .catch(console.error)
  discord.on "ready", ->
    console.log('Connected to Discord Server')
    debugChannel = discord.channels.find("name", "debug")
    rustChannel = discord.channels.find("name", "rust-server")
    wRcon(process.env.RUST_IP, process.env.RUST_PORT, process.env.RUST_PASSWORD)

wRcon = (rustip, rustport, password) ->
  wRcon = new WebRcon(rustip, rustport)
  wRcon.connect(password)
  wRcon.on "connect", -> console.log "Connected to Rust Server"
  wRcon.on "disconnect", -> errorNotification("Disconnected from Rust Server")
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

discordClient(process.env.DISCORD_TOKEN)
