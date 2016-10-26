class CreateBike < ActiveRecord::Migration[5.0]
  def change
    create_table :bikes do |t|
      t.integer :totalcapacity
      t.string :type
      t.float :lan
      t.float :lon
    end
  end
end
