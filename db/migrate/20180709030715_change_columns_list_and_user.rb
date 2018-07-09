class ChangeColumnsListAndUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :listings, :role, :integer
    add_column :listings, :verification, :boolean
    add_column :users, :role, :integer
  end
end
