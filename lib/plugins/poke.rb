class Poke
  include Cinch::Plugin
  
  match /poke (.+)/
  def execute(m, who)
    m.action_reply "pokes #{who.strip}"
  end
end
