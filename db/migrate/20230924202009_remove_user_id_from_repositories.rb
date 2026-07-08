class RemoveUserIdFromRepositories < ActiveRecord::Migration[6.1]
  def change
    if column_exists?(:repositories, :user_id)
      remove_column :repositories, :user_id, :bigint
    end
  end
end
