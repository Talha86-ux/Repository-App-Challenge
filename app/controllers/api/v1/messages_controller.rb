class Api::V1::MessagesController < ApplicationController
  def index
    chatroom = Chatroom.find(params[:chatroom_id])
    messages = chatroom.messages.order(created_at: :asc)
    render json: messages.as_json(only: [:body, :user_id])
  end

  def create
    chatroom = Chatroom.find(params[:chatroom_id])
    message = chatroom.messages.build(message_params.merge(user_id: current_user.id))

    if message.save
      render json: message, status: :created
    else
      render json: { errors: message.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:body, :user_id)
  end
end