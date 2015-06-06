require 'cinch'
require 'open-uri'
require 'nokogiri'
require 'json'

require_relative 'plugins/compliment'
require_relative 'plugins/insult'
require_relative 'plugins/encourage'
require_relative 'plugins/poke'
require_relative 'plugins/quit'
require_relative 'plugins/flip'
require_relative 'plugins/rant'
require_relative 'plugins/echo'

NICK = 'HellBot'

bot = Cinch::Bot.new do
  configure do |c|
    c.nick = 'HellBot',
    c.server = 'irc.esper.net'
    c.channels = ['#InfernalSkies']
    c.plugins.plugins = [Insult, Encourage, Compliment, Poke, Quit, Flip, Unflip, Rant, Echo]
  end
end

bot.start