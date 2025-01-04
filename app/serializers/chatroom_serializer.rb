class ChatroomSerializer < ActiveModel::Serializer
  attributes :id, :title, :users, :messages
  
  attribute :users do |room|
    UserSerializer.new(room.users.uniq)
  end
end