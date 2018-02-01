class CreateCars < ActiveRecord::Migration[5.1]
  def change
    create_table :cars do |t|
      t.primary_key :vin
      t.float :odometer

      t.timestamps
    end
  end
end
