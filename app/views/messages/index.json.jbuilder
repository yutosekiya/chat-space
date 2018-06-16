json.messages @new_messages.each do |message|
  json.name message.user.name
  json.time format_posted_time(message.created_at)
  json.content message.content
  json.image message.image.url
  json.id   message.id
end

