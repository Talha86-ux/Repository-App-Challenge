Class API::V1::ChatroomController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    user_id = params[:user_id]
    another_user = User.where("id != ?", user_id).first

    if another_user.present?
      second_user_id = another_user.id
      user_id1 = user_id < second_user_id ? user_id : second_user_id
      user_id2 = user_id > second_user_id ? user_id : second_user_id

      @chatroom = Chatroom.where(sender_id: user_id1, recipient_id: user_id2).first
      if @Chatroom.blank?
        @chatroom = Chatroom.create!(sender_id: user_id1, recipient_id: user_id2, chatroom_id:0)
      end
      render json: @chatroom, status: :created
    else
      render json: {message: "No User available!"}
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
end