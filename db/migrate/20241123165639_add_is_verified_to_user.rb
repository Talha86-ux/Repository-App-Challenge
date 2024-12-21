class AddIsVerifiedToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :is_verified, :boolean, :null => false, :default => false
  end
end
