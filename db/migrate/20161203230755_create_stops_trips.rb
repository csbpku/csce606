class CreateStopsTrips < ActiveRecord::Migration[5.0]
  def change
    create_table :stops_trips do |t|
      t.time :arrival_time
      t.time :departure_time
      t.integer :stop_sequence
      t.integer :pickup_type
      t.integer :drop_off_type
      t.float :shape_dist_traveled
      t.references :stop
      t.references :trip
    end
  end
end
