class AddColumnToListings < ActiveRecord::Migration[5.2]
  def change
    add_column :listings, :name, :string
    add_column :listings, :description, :string
    add_column :listings, :price, :decimal
    add_column :listings, :location, :string
  end
end
