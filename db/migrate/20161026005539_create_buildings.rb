class CreateBuildings < ActiveRecord::Migration[5.0]
  def change
    create_table :buildings do |t|
      t.integer :number
      t.string :abbr
      t.string :name
      t.string :address
      t.integer :numberoffloors
      t.float :lan
      t.float :lon
    end
  end
end
