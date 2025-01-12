API::V1::class MessagesController < ApplicationController

  def index
    messages = Message.where(chatroom_id: params[:chatroom_id]).order(id: :asc)
    render json: messages
  end

  def create
    user = User.find(params[:message][:user_id])
    chatroom = Chatroom.find(params[:message][:chatroom_id])
    message = chatroom.messages.build(message_params)

    if message.save
      ActionCable.server.broadcast('chatroom_channel', message: message.content, user: user.first_name)
    else
      render json: message.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    message = Message.find(params[:message_id])
    message.destroy
  end

  private
  def message_params
    params.require(:message).permit(:body, :user_id, :chatroom_id)
  end
end