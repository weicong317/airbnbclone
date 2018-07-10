class ChangeAvatarColumnInUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :avatar, :string
    add_column :users, :avatar, :json
  end
end
