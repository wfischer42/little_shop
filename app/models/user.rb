class User < ApplicationRecord
  validates_presence_of :name, :address, :city, :state,
                        :zip_code, :role, :password, :email,
                        require: true

  validates :zip_code, numericality: true
  validates :email, uniqueness: true

  has_secure_password

  enum role: [:customer, :merchant, :admin]
end
