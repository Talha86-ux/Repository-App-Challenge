class User < ApplicationRecord
  has_secure_password

  has_many :user_repositories
  has_many :repositories, through: :user_repositories

  validates :first_name, presence: {message: 'This field is required.'}
  validates :last_name, presence: {message: 'This field is required.'}
  validates :email, presence: {message: 'This field is required.'}
  validates :email, uniqueness: { message: 'This email is already taken.' }

  def generate_password_reset_token
    self.reset_password_token = SecureRandom.urlsafe_base64
    self.reset_password_token_sent_at = Time.current
    save!
  end

  def password_token_valid?
    (self.reset_password_token_sent_at + 1.hour) > Time.current
  end

  def reset_password(password, password_confirmation)
    self.reset_password_token_sent_at = nil
    self.password = password
    self.password_confirmation = password_confirmation
    save!
  end
end
