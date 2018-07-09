class AddColumnToListing < ActiveRecord::Migration[5.2]
  def change
    add_column :listings, :admin, :boolean
    add_column :listings, :moderator, :boolean
    add_column :listings, :customer, :boolean
  end
end
