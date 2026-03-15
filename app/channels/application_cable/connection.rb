module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

    def find_verified_user
      token = request.params[:token] || request.headers["Authorization"]&.split(" ")&.last
      reject_unauthorized_connection unless token.present?

      decoded_token = begin
        JWT.decode(token, JWT_SECRET_KEY, true, { algorithm: JWT_ALGORITHM })
      rescue JWT::DecodeError, JWT::VerificationError, JWT::ExpiredSignature => _exception
        nil
      end

      if decoded_token && (user = User.find_by(id: decoded_token.first["user_id"]))
        user
      else
        reject_unauthorized_connection
      end
    end
  end
end
