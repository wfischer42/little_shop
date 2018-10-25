class AddDefaultPictureToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :user_img_url, :string, default: "https://www.psgdental.com/wp-content/uploads/2017/04/default-placeholder.jpg"
  end
end
