class ChatroomChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from "chatroom_channel_#{params[:conversation_id]}"
    ActionCable.server.broadcast('chatroom_channel', message: 'Channel Subscribed')
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    stop_all_streams
  end

  def received(data)
    user = User.find(data['user_id'])
    message = Message.create!(user: user, content: data['content'])
    ActionCable.server.broadcast('chat_channel', {
      message: render_message(message)
    })
  end
end
