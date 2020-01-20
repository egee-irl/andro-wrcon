class RustEvents
  constructor: (wRcon) ->
    debugChannel = helpers.discordChannel('debug')
    rustChannel = helpers.discordChannel('rust-server')

    wRcon.on 'connect', -> console.log 'Connected to Rust Server'
    wRcon.on 'disconnect', ->
      helpers.errorNotification('Disconnected from Rust Server', debugChannel)
    wRcon.on 'error', (err) ->
      helpers.errorNotification("wRcon #{err}", debugChannel)
    wRcon.on 'message', (msg) ->
      if msg.message.includes('has entered the game')
        playerJoin = msg.message.replace(/\[.*\]/, '')
        rustChannel.fetchMessage(rustChannel.lastMessageID)
        .then (message) ->
          if playerJoin != message.content
            rustChannel.send(playerJoin)
            rustJoin = playerJoin.replace('entered', 'joined')
            wRcon.run('say ' + rustJoin, 0)
        .catch ((error) -> helpers.errorNotification(error, debugChannel))
      else console.log(msg.message)

module.exports = RustEvents
