module.exports = (robot) ->

  robot.router.post '/slack-event', (req, res) ->
    if req.body.type == 'url_verification'
      # Slack API Check
      res.send req.body.challenge
    else if req.body.type == 'channel_created'
      # channel_created
      robot.messageRoom '00_おしらせ', '新しくチャンネルが作成されました！ 👉 #' + req.body.channel.name
      res.end
