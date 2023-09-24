class RemoveUserIdFromRepositories < ActiveRecord::Migration[6.1]
  def change
    remove_column :repositories, :user_id, :bigint
  end
end
