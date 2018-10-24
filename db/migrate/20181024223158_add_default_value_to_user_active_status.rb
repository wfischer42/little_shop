class AddDefaultValueToUserActiveStatus < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :active, :boolean, default: true
  end
end
