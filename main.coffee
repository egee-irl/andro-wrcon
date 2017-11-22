WebRcon = require("webrconjs")
DiscordJs = require('discord.js')

discord = new DiscordJs.Client()
discord.login(process.env.PYGUY)

debugChannel = ""
rustChannel = ""

discord.on "ready", ->
  debugChannel = discord.channels.find("name", "debug")
  rustChannel = discord.channels.find("name", "rust-server")

wRcon = new WebRcon(process.env.RUST_IP, 28016)
wRcon.connect(process.env.RUST_PASSWORD)
wRcon.on "connect", -> console.log "Connected!"
wRcon.on "disconnect", -> notification("wRcon received a disconnect event.")
wRcon.on "error", (err) -> notification("wRcon failed: #{err}")
wRcon.on "message", (msg) ->
  if msg.message.includes("has entered the game")
    playerJoin = msg.message.replace(/\[.*\]/, "")
    rustChannel.fetchMessage(rustChannel.lastMessageID)
    .then (message) ->
      console.log 'equality' if playerJoin != message.content

# wRcon.run("say " + message, 0) if message.includes("has entered the game")
# wRcon.run("env.time 9", 0) if message.includes("rust time")

notification = (type) ->
  message = "Something went wrong: #{type}"
  console.log(message)
  process.exit(1)
