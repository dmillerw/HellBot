ADMINS = ['dmillerw', 'CyanideX']

class Quit
  include Cinch::Plugin

  match /quit/
  def execute(m)
    if ADMINS.include?(m.user.nick)
      m.bot.quit
      Sinatra::Application.quit!
    else
      m.reply "I'm sorry #{m.user.nick}, but I cannot do that"
    end
  end
end