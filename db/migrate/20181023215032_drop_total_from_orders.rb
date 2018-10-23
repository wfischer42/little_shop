class DropTotalFromOrders < ActiveRecord::Migration[5.1]
  def change
    remove_column :orders, :total
  end
end
