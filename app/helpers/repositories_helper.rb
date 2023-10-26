module RepositoriesHelper

  def display_repository_users(users)
    user_ids = JSON.parse(users).reject(&:empty?).map(&:to_i)
    user_ids.map { |user_id| User.find_by(id: user_id)&.first_name }
  end
end
