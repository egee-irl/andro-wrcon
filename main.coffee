RustEvents = require('./lib/rust-events.coffee')
WebRcon = require('webrconjs')

getWrconConnection = () ->
  wRcon = new WebRcon(localhost, 28016)
  wRcon.connect('_')
  return wRcon

new RustEvents(getWrconConnection())
