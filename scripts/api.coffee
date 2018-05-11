module.exports = (robot) ->
# Slack API Check
  # robot.router.post '/webhook', (req, res) ->
  #   console.log(req)
  #   res.send req.body.challenge
# channel_created
  robot.router.post '/webhook', (req, res) ->
    if req.body.type == 'channel_created'
      robot.messageRoom '00_おしらせ', '新しくチャンネルが作成されました！ 👉 #' + req.body.channel.name
      res.end