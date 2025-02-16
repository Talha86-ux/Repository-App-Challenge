class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_content_security_policy_nonce

  def jwt_key
    Rails.application.credentials.jwt_key || JWT_SECRET_KEY
  end
  
  def issue_token(user)
    JWT.encode({user_id: user.id}, jwt_key, JWT_ALGORITHM)
  end

  def decoded_token
    begin
      JWT.decode(token, jwt_key, true, { :algorithm => JWT_ALGORITHM })
    rescue => exception
      [{error: "Invalid Token"}]
    end    
  end

  def token
    return unless request.headers["Authorization"].present?
    
    request.headers["Authorization"].split(" ").last
  end

  def user_id
    decoded_token.first["user_id"]
  end

  def current_user
    user_id = decoded_token.first["user_id"] if decoded_token && decoded_token.first
    @current_user ||= User.find_by(id: user_id) if user_id
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
