class CreateRepositories < ActiveRecord::Migration[6.1]
  def change
    create_table :repositories do |t|
      t.string :name
      t.text :description
      t.string :owner
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
