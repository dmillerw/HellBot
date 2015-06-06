class Insult
  include Cinch::Plugin

  match /insult (.+)/
  def execute(msg, receiver)
    # Replace with proper ignore handler~
    if msg.user.user.include? 'MattDahEp'
        msg.reply 'I\'ve been told not to take orders from you...'
        return
      end

      user = receiver.strip
      if receiver.include? 'dmillerw'
        user = msg.user.nick.strip
      end
      insult = Nokogiri.parse(open('http://www.randominsults.net/').read).at('i').text.to_s
      msg.reply "#{user}: #{insult}"
    end
end

