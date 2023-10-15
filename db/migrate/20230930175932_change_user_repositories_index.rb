class ChangeUserRepositoriesIndex < ActiveRecord::Migration[6.1]
  def change
    remove_index :user_repositories, [:user_id, :repository_id]
    
    add_index :user_repositories, [:user_id, :repository_id], unique: false
  end
end
