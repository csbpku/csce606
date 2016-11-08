class BikeUpdate < ActiveRecord::Migration[5.0]
  def change
      change_table :bikes do |t|
	    t.remove :totalcapacity, :type, :lan, :lon
	    t.string :typeofrack
      	t.integer :typeQuantity
      	t.integer :total_Capacity 
      	t.float :lat
      	t.float :lon
      end
  end
end
