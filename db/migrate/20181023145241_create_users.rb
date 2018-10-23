class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.integer :zip_code
      t.string :email
      t.string :password_digest
      t.integer :role, default: 0
      t.boolean :active

      t.timestamps
    end
  end
end
