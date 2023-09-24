class CreateUserRepositories < ActiveRecord::Migration[6.1]
  def change
    create_table :user_repositories do |t|
      t.boolean :private, default: false
      t.references :user, foreign_key: true
      t.references :repository, foreign_key: true
      
      t.timestamps
    end
    add_index :user_repositories, [:user_id, :repository_id], unique: true
  end
end
