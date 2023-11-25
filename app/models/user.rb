class User < ApplicationRecord
  has_secure_password

  has_many :user_repositories
  has_many :repositories, through: :user_repositories

  validates :first_name, presence: {message: 'This field is required.'}
  validates :last_name, presence: {message: 'This field is required.'}
  validates :email, presence: {message: 'This field is required.'}
  validates :email, uniqueness: { message: 'This email is already taken.' }
end
