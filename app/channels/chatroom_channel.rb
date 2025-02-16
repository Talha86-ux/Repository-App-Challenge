class ChatroomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "ChatroomChannel_#{params[:chatroom_id]}"
    ActionCable.server.broadcast("ChatroomChannel_#{params[:chatroom_id]}", message: 'Channel Subscribed')
  end

  def unsubscribed
    stop_all_streams
  end

  def send_message(data)
    user = User.find(data['user_id'])
    chatroom = Chatroom.find(data['chatroom_id'])
    message = Message.create!(user: user, chatroom: chatroom, body: data['content'])

    ActionCable.server.broadcast("ChatroomChannel_#{data['chatroom_id']}", {
      message: {
        id: message.id,
        body: message.body,
        user: {
          id: user.id,
          first_name: user.first_name
        }
      }
    })
  end

  private

  def render_message(message)
    ApplicationController.renderer.render(partial: 'messages/message', locals: { message: message })
  end
end
