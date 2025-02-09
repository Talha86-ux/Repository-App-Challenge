class ChatroomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "#{params["channel"]}"
    ActionCable.server.broadcast("#{params["channel"]}", message: 'Channel Subscribed')
  end

  def unsubscribed
    stop_all_streams
  end

  def send_message(data)
    user = User.find(data['user_id'])
    channel = Chatroom.find(data['chatroom_id'])
    byebug     
    message = Message.create!(user: user, body: data['content'])

    ActionCable.server.broadcast("#{params["channel"]}", {
      message: render_message(message)
    })
  end
end
