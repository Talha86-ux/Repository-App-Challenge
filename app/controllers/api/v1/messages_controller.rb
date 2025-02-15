class Api::V1::MessagesController < ApplicationController
  def index
    messages = Message.all
    render json: messages.as_json(only: [:body], include: { user: { only: [:id, :first_name] } })
  end

  def create
    user = User.find(params[:message][:user_id])
    chatroom = Chatroom.find(params[:message][:chatroom_id])
    message = chatroom.messages.build(message_params)

    if message.save
      ActionCable.server.broadcast('chatroom_channel', message: message.body, user: user.first_name)
    else
      render json: { errors: message.errors.full_messages }, status: 422
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