class Item < ApplicationRecord
  belongs_to :user
  belongs_to :merchant, class_name: :User, foreign_key: "user_id"
  has_many :order_items
  has_many :orders, through: :order_items

  validates_presence_of :name, :description, :price, :img_url, require: true
  validates :price, numericality: {greater_than_or_equal_to: 0}
  validates :inventory_count, numericality: {greater_than_or_equal_to: 0}

  def self.most_popular
  end

end
