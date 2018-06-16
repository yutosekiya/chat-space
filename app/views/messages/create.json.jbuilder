json.name    @message.user.name
json.content @message.content
json.image   @message.image.url
json.time    format_posted_time(@message.created_at)
json.id      @message.id
