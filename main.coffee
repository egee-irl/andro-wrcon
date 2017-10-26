WebRcon = require('webrconjs')
Redis = require('redis')

rcon = new WebRcon(process.env.RUST_IP, process.env.RUST_PORT)
rcon.connect(process.env.RUST_PASSWORD)
rcon.on 'connect', -> console.log 'Connected!'
rcon.on 'disconnect', -> console.log 'Disconnected :('
rcon.on 'error', (err) -> console.log 'ERROR: ' + err

redis = Redis.createClient( { host: 'localhost' } )
redis.subscribe 'RustCommands'
redis.on 'error', (err) -> console.log(err)
redis.on 'message', (channel, message) ->
  if message.includes('has entered the game')
    rcon.run('say ' + message, 0)
  else if message.includes('rust time')
    rcon.run('env.time 9', 0)
  console.log(message)
