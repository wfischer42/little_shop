class User < ApplicationRecord
  validates_presence_of :name, :address, :city, :state,
                        :zip_code, :role, :email,
                        require: true

  validates :zip_code, numericality: true
  validates :email, uniqueness: true

  validates_presence_of :password, :on => :create

  has_secure_password

  enum role: [:customer, :merchant, :admin]
end
