class Api::V1::ChatroomsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index 
    chatrooms = Chatroom.all
    render json: chatrooms.as_json(only: [:id, :name])
  end

  def create
    chatroom = Chatroom.new(chatroom_params)
    if chatroom.save!
      render json: { chatroom: chatroom, message: "Chatroom created successfully!" }, status: 201
    else
      render json: { errors: chatroom.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def login
    user = User.find(params[:id])
    user.update(available: true)
    render json: {message: "Logged in successfully!"}
  end

  def destroy
    chatroom = Chatroom.find(params[:id])
    chatroom.destroy
  end

  private

  def chatroom_params
    params.require(:chatroom).permit(:name)
  end
end