class CreateCarInformations < ActiveRecord::Migration[5.1]
  def change
    create_table :car_informations do |t|
      t.float :average_fuel_consumption
      t.float :distance_traveled
      t.integer :average_rpm
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
