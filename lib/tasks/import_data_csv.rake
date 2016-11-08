require 'csv'
namespace :import_data_csv do
  task :create_buildings_position => :environment do
    CSV.foreach(File.expand_path("Data/building.csv"), :headers=>true) do |row|
      Buildings.create!(row.to_hash)
    end
  end
  
  task :create_cars_parking => :environment do
    CSV.foreach(File.expand_path("Data/car_parking.csv"), :headers=>true) do |row|
      Cars.create!(row.to_hash)
    end
  end
 task :create_bike_racks => :environment do
    CSV.foreach(File.expand_path("Data/BikeRack.csv"), :headers=>true) do |row|
      Bikes.create!(row.to_hash)
    end
  end
end