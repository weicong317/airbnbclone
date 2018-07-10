class AddImageToListings < ActiveRecord::Migration[5.2]
  def change
    add_column :listings, :rooms, :json
  end
end
