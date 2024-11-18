class Api::V1::UsersController < ApplicationController
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token

  def create
    user = User.new(user_params)
    if user.save
      token = issue_token(user)
      render json: { user: Api::V1::UserSerializer.new(user), jwt: token }

      UserMailer.welcome_user(user).deliver_now
    else
      render json: { error: user.errors.messages || "Couldn't create a new user! Please try again." }
    end
  end

  private

  def user_params
    params.permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end