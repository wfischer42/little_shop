class AddDefaultValueToImageUrl < ActiveRecord::Migration[5.1]
  def change
    change_column :items, :img_url, :string, default: "http://equip2clean.co.uk/media/catalog/product/cache/4/image/500x600/9df78eab33525d08d6e5fb8d27136e95/placeholder/default/placeholder.jpg"
  end
end
