class AddGuidToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :guid, :integer
  end
end
