class Echo
  include Cinch::Plugin

  def initialize(*args)
    super

    load_callbacks @bot
  end

  def load_callbacks(bot)
    if File.exist?('callbacks.txt')
      File.readlines('callbacks.txt').each do |line|
          array = line.split(':')
          load_callback bot, array[0], array[1]
      end
    end
  end

  def save_callback(tag, msg)
    File.open('callbacks.txt', 'a') {
      |file| file.puts("#{tag}:#{msg}\n")
    }
  end

  def load_callback(bot, tag, msg)
    bot.on :message, /^!#{Regexp.quote(tag)}/ do |m|
      m.reply msg
    end
  end

  match /echo (.+) (.+)/
  def execute(msg, name, message)
    # Replace with proper ignore handler
    if msg.user.user.include? 'MattDahEp'
      msg.reply 'I\'ve been told not to take orders from you...'
      return
    end

    split = name.split(' ')
    if split.size > 1
      # All the hacks. I don't understand Regex enough to fix it any other way...
      name = split[0]
      split.shift
      message = split.push(message).join(' ')
    end
    msg.reply "Added echo callback for \"#{name}\""
    save_callback(name, message)
    load_callback(msg.bot, name, message)
  end
end