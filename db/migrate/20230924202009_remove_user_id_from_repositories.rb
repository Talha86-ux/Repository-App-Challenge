class RemoveUserIdFromRepositories < ActiveRecord::Migration[6.1]
  def change
    remove_column :repositories, :user_id, :bigint, if_exists: true
  end
end
