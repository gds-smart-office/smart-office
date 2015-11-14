require 'telegram/bot'
require 'open-uri'

token = 'your_token'
webcom_ip = 'your_ip'

Telegram::Bot::Client.run(token) do |bot|
  puts "smart-office started"
  bot.listen do |message|
    case message.text
      when '/start'
        puts "start"
        bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")
      when '/stop'
        puts "stop"
        bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
      when '/photo'
        puts "photo request from #{message.from.first_name} #{message.from.last_name}"
        begin  
          open('photo.jpg', 'wb') do |file|
            file << open('http://#{webcom_ip}/photo.jpg').read
          end
          bot.api.send_photo(chat_id: message.chat.id, photo: File.new('photo.jpg'))
        rescue Exception => e  
          bot.api.send_message(chat_id: message.chat.id, text: e.message)
        end

      else
        puts "else"
    end
  end
end
