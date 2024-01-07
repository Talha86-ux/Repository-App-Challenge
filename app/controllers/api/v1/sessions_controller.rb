
class Api::V1::SessionsController < ApplicationController
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token

  def create
    user = User.find_by_email(session_params[:email])

    if user && user.authenticate(session_params[:password])
      token = issue_token(user)
      render json: {user: Api::V1::UserSerializer.new(user), jwt: token}
    else
      render json: {error: "Incorrect username or password."}
    end
  end

  def show
    if logged_in?
      render json: current_user
    else
      render json: {error: "User is not logged in / could not be found."}
    end
  end

  private
  def session_params
    params.permit(:email, :password)
  end
end