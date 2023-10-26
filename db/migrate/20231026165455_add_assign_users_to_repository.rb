class AddAssignUsersToRepository < ActiveRecord::Migration[6.1]
  def change
    add_column :repositories, :assign_users, :string
  end
end
