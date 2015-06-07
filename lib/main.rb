require 'cinch'
require 'open-uri'
require 'nokogiri'
require 'json'
require 'sinatra'

require_relative 'plugins/compliment'
require_relative 'plugins/insult'
require_relative 'plugins/encourage'
require_relative 'plugins/poke'
require_relative 'plugins/quit'
require_relative 'plugins/flip'
require_relative 'plugins/rant'
require_relative 'plugins/echo'

NICK = 'HellBot'

$global_bot = Cinch::Bot.new do
  configure do |c|
    c.nick = NICK
    c.user = NICK
    c.realname = NICK
    c.server = 'irc.esper.net'
    c.channels = ['#InfernalSkies']
    c.plugins.plugins = [Insult, Encourage, Compliment, Poke, Quit, Flip, Unflip, Rant, Echo]
  end
end

$web_thread = Thread.new do
  # I should really not hard-code this...
  get '/bot/send/*/*' do
    $global_bot.channel_list.each do |channel|
      if params['splat'][0] == 'all' || channel.to_s == params['splat'][0]
        channel.send params['splat'][1]
      end
    end
    return 'SENT'
  end
end

Thread.new do
  $global_bot.start
end