class CreateBuses < ActiveRecord::Migration[5.0]
  def change
    create_table :stops do |t|
      t.integer :code
      t.string :name
      t.text :desc
      t.float :lan
      t.float :lon
      t.integer :location_type
    end
    
    create_table :stop_times do |t|
      t.time :arrival_time
      t.time :departure_time
      t.integer :stop_sequence
      t.integer :pickup_type
      t.integer :drop_off_type
      t.float :shape_dist_traveled
      t.references :stop
      t.references :trip
    end
    
    create_table :trips do |t|
      t.integer :headsign
      t.integer :direction_id
      t.string :block_id
      t.references :route
      t.references :calendar
      t.references :shape
    end
    
    create_table :routes do |t|
      t.string :short_name
      t.string :long_name
      t.text :desc
      t.integer :type
      t.string :color
      t.string :text_color
    end
    
    create_table :shapes do |t|
      t.integer :shape_id
      t.float :pt_lan
      t.float :pt_lon
      t.integer :pt_sequence
      t.float :shape_dist_traveled
    end
    
    create_table :calendars do |t|
      t.integer :monday
      t.integer :tuesday
      t.integer :wednesday
      t.integer :thursday
      t.integer :friday
      t.integer :saturday
      t.integer :sunday
      t.date :start_date
      t.date :end_date
    end
    
    create_table :calendar_dates do |t|
      t.date :date
      t.integer :exception_type
      t.references :calendar
    end
  end
end
