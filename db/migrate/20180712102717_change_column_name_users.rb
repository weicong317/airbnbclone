class ChangeColumnNameUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :avatar_url, :google_url
  end
end
