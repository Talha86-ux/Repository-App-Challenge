class User < ApplicationRecord
  has_many :user_repositories
  has_many :repositories, through: :user_repositories
end
