class Car < ApplicationRecord
  has_many :car_informations
  validates :vin, presence: true, uniqueness: true
end
