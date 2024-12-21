class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_content_security_policy_nonce

  def jwt_key
    Rails.application.credentials.jwt_key
  end

  def jwt_key
    Rails.application.credentials.jwt_key
  end
  
  def issue_token(user)
    JWT.encode({user_id: user.id}, jwt_key, "HS256")
  end

  def decoded_token
    begin
      JWT.decode(token, jwt_key, true, { :algorithm => 'HS256' })
    rescue => exception
      [{error: "Invalid Token"}]
    end    
  end

  def token
    request.headers["Authorization"]
  end

  def user_id
    decoded_token.first["user_id"]
  end

  def current_user
    user ||= User.find_by(id: params[:id])
  end

  def logged_in?
    !!current_user
  end

  private

  def set_content_security_policy_nonce
    @content_security_policy_nonce = SecureRandom.base64(16)
    response.headers['Content-Security-Policy'] = "script-src 'self' 'nonce-#{@content_security_policy_nonce}';"
  end
end
