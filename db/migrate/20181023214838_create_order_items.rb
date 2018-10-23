class CreateOrderItems < ActiveRecord::Migration[5.1]
  def change
    create_table :order_items do |t|
      t.references :item, foreign_key: true
      t.references :order, foreign_key: true
      t.integer :item_quantity
      t.decimal :item_price, precision: 15, scale: 2

      t.timestamps
    end
  end
end
