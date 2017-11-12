WebRcon = require("webrconjs")
Redis = require("redis")
redis = Redis.createClient( { host: process.env.REDIS } )

wRcon = new WebRcon(process.env.RUST_IP, 80)
wRcon.connect(process.env.RUST_PASSWORD)
wRcon.on "connect", -> console.log "Connected!"
wRcon.on "disconnect", -> notification("wRcon received a disconnect event.")
wRcon.on "error", (err) -> notification("wRcon failed with the following #{err}")

redis.subscribe "RustCommands"
redis.on "error", (err) ->
  console.log(err)
  process.exit(1)
redis.on "message", (channel, message) ->
  wRcon.run("say " + message, 0) if message.includes("has entered the game")
  wRcon.run("env.time 9", 0) if message.includes("rust time")
  console.log(message)

notification = (type) ->
  message = "Something went wrong: #{type}"
  console.log(message)
  redis.publish("error", message)
  process.exit(1)
  
