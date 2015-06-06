require 'net/http'
require 'uri'
require 'json'

class Rant
  include Cinch::Plugin

  match /rant (.+)/
  def execute(msg, arg)
    # Replace with proper ignore handler
  if msg.user.user.include? 'MattDahEp'
      msg.reply 'I\'ve been told not to take orders from you...'
      return
    end

    uri = URI.parse('http://rant.berkin.me/rantbox/run')
    data = {
        'code' => arg,
        'nsfw' => 'false'
    }
    resp = Net::HTTP.post_form(uri, data)
    json = JSON.parse(resp.body)

    if json['success'] == 'ok'
      msg.reply json['result']
    else
      msg.reply 'FAILED'
    end
  end
end