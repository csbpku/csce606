class CreateCars < ActiveRecord::Migration[5.0]
  def change
    create_table :cars do |t|
      t.string :lotname
      t.string :lottype
      t.float :lat
      t.float :lon
    end
  end
end
