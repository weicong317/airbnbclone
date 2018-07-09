class ModifyColumnListing < ActiveRecord::Migration[5.2]
  def change
    remove_column :listings, :admin, :boolean
    remove_column :listings, :moderator, :boolean
    remove_column :listings, :customer, :boolean
    add_column :listings, :role, :integer
  end
end
