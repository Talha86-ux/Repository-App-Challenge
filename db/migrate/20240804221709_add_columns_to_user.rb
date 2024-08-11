class AddColumnsToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :reset_password_token, :string
    add_column :users, :reset_password_token_sent_at, :datetime
  end
end
