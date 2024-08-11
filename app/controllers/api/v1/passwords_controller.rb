class Api::V1::PasswordsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def forgot_password
    user = User.find_by(email: params[:email])

    if user.present?
      user.generate_password_reset_token
      render json: { reset_token: user.reset_password_token }, status: :ok
    else
      render json: { error: 'Email not found' }, status: :not_found
    end
  end

  def update_password
    user = User.find_by(reset_password_token: params[:reset_password_token])
  
    if user.present? && user.password_token_valid?
      if user.reset_password(params[:password], params[:password_confirmation])
        render json: { user: user }, status: :ok
      else
        render json: { error: user.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Token not valid or expired' }, status: :not_found
    end
  end

  private

  def password_reset_params
    params.permit(:email, :password, :password_confirmation, :reset_password_token)
  end
end