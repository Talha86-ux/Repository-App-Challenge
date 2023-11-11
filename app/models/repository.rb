class Repository < ApplicationRecord
  has_many :user_repositories
  has_many :users, through: :user_repositories, dependent: :destroy
end
