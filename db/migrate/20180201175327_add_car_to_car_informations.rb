class AddCarToCarInformations < ActiveRecord::Migration[5.1]
  def change
    add_reference :car_informations, :car, foreign_key: true
  end
end
