class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.decimal :price, precision: 15, scale: 2
      t.integer :inventory_count, default: 0
      t.text :description
      t.string :img_url

      t.timestamps
    end
  end
end
