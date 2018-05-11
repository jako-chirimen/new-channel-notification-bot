module.exports = (robot) ->
  robot.respond /who are you/i, (msg) ->
   　msg.send "I'm hubot!"