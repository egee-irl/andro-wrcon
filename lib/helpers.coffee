class Helpers
  reoccuringErrors = 0
  constructor: () ->

  errorNotification: (error, channel) ->
    process.exit(1) if reoccuringErrors > 10
    console.log(error)
    channel.send(error)
    .then(reoccuringErrors++)

module.exports = Helpers
