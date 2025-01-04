class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chatroom

  validates :body, presence: {message: 'This field is required.'}
end