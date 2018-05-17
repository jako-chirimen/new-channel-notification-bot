module.exports = (robot) ->

  robot.router.post '/slack-event', (req, res) ->
    switch req.body.type
      when 'url_verification'
        # Slack API Check
        res.send req.body.challenge
      when 'channel_created'
        # channel_created
        robot.messageRoom '00_おしらせ', '新しくチャンネルが作成されました！ 👉 #' + req.body.channel.name
        res.end
      else 
        console.info req.body
        res.end
