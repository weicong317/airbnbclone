class ModifyUploadCondition < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :avatar, :json
    add_column :users, :avatar, :string
  end
end
