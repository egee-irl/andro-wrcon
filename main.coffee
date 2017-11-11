WebRcon = require('webrconjs')
Redis = require('redis')

wRcon = new WebRcon(process.env.RUST_IP, process.env.RUST_PORT)
wRcon.connect(process.env.RUST_PASSWORD)
wRcon.on 'connect', -> console.log 'Connected!'
wRcon.on 'disconnect', -> console.log 'Disconnected :('
wRcon.on 'error', (err) -> console.log 'ERROR: ' + err

redis = Redis.createClient( { host: process.env.REDIS } )
redis.subscribe 'RustCommands'
redis.on 'error', (err) -> console.log(err)
redis.on 'message', (channel, message) ->
  if message.includes('has entered the game')
    wRcon.run('say ' + message, 0)
  else if message.includes('rust time')
    wRcon.run('env.time 9', 0)
  console.log(message)
