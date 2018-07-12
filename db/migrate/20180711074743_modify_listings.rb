class ModifyListings < ActiveRecord::Migration[5.2]
  def change
    remove_column :listings, :location, :string
    add_column :listings, :address, :string
    add_column :listings, :amenities, :text, :array => true, :default => []
    add_column :listings, :country, :string
  end
end
