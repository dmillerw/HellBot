class Compliment
  include Cinch::Plugin
  
  def initialize(*args)
    super
    
    # Just in case the parsing fails
    @compliments = [
      "You\'re funny. Like, LOL style.",
      "Your voice sounds like a thousand cats purring. Also, I\'m on acid.",
      'You think of the funniest names for wi-fi networks.',
      'People at trivia night are terrified of you.'
    ]
    
    body = open('https://spreadsheets.google.com/feeds/list/1eEa2ra2yHBXVZ_ctH4J15tFSGEu-VTSunsrvaCAV598/od6/public/values?alt=json').read
    
    parsed = JSON.parse(body)
    parsed['feed']['entry'].each do |entry|
      @compliments.push entry['title']['$t']
    end
  end
  
  match /compliment (.+)/
  def execute(m, receiver)
    compliment = @compliments.sample
    m.reply "#{receiver.strip}: #{compliment}"
  end
end
