module.exports = (robot) ->
# Slack API Check
  # robot.router.post '/webhook', (req, res) ->
  #   console.log(req)
  #   res.send req.body.challenge
# channel_created
  # robot.router.post '/webhook', (req, res) ->
  #   if req.type == 'channel_created'
  #     robot.messageRoom 'slack-test', 'New channel 👉 #' + req.channel.name
  #     res.end
  robot.router.post '/webhook', (req, res) ->
    robot.messageRoom 'slack-test', 'なんかきた'
    res.end