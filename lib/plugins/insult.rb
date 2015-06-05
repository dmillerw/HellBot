class Insult
  include Cinch::Plugin

  match /insult (.+)/
  def execute(m, receiver)
    user = receiver.strip
    if receiver.include? "dmillerw"
      user = m.user.nick.strip
    end
    insult = Nokogiri.parse(open("http://www.randominsults.net/").read).at("i").text.to_s
    m.reply "#{user}: #{insult}"
  end
end

