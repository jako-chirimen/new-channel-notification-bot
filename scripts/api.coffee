module.exports = (robot) ->
  robot.router.post '/slack-event', (req, res) ->
    if req.body.type is 'event_callback'
      switch req.body.event.type
        when 'channel_created'
          # channel_created
          channelName = req.body.event.channel.name
          robot.messageRoom process.env.INFO_CHANNEL, '新しくチャンネルが作成されました！ 👉 #' + channelName
          res.send "OK"

        when 'file_created'
          robot.http("https://slack.com/api/files.info?token=#{process.env.SLACK_API_TOKEN}&file=#{req.body.event.file.id}&pretty=1")
            .get() (err, res, body) ->
              data = JSON.parse body
              if data.ok is true
                if /image/.test(data.file.mimetype)
                  # processing image backup
                  console.log('image type')

          robot.http("https://slack.com/api/files.list?token=#{process.env.SLACK_API_TOKEN}")
            .get() (err, res, body) ->
              data = JSON.parse body
              if data.ok is true
                console.log(data.files.length)
                if data.files.length >= process.env.FILE_LIMIT
                   # delete old file
                   robot.http("https://slack.com/api/files.delete?token=#{process.env.SLACK_API_TOKEN}&file=#{data.files[data.files.length-1].id}&pretty=1")
                     .get() (err, res, body) ->
                       # deleted
                       console.log(body)
                       robot.http("https://slack.com/api/files.list?token=#{process.env.SLACK_API_TOKEN}")
                         .get() (err, res, body) ->
                           data = JSON.parse body
                           console.log(data.files.length)
          res.send "OK"

        else 
          console.log req.body
          res.send "OK"

    else if req.body.type is 'url_verification'
      # Slack API Check
      res.send req.body.challenge
