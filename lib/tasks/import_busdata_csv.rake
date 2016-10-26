require 'csv'
namespace :import_busdata_csv do
  task :create_calendar_dates => :environment do
    CSV.foreach(File.expand_path("BusData/combinedData/calendar_dates.csv"), :headers=>true) do |row|
      Calendar_date.create!(row.to_hash)
    end
  end
  task :create_calendars => :environment do
    CSV.foreach(File.expand_path("BusData/combinedData/calendar.csv"), :headers=>true) do |row|
      Calendar.create!(row.to_hash)
    end
  end
  task :create_routes => :environment do
    CSV.foreach(File.expand_path("BusData/combinedData/routes.csv"), :headers=>true) do |row|
      Route.create!(row.to_hash)
    end
  end
  task :create_points => :environment do
    CSV.foreach(File.expand_path("BusData/combinedData/points.csv"), :headers=>true) do |row|
      Point.create!(row.to_hash)
    end
  end
  task :create_stop_times => :environment do
    CSV.foreach(File.expand_path("BusData/combinedData/stop_times.csv"), :headers=>true) do |row|
      Stop_time.create!(row.to_hash)
    end
  end
  task :create_stops => :environment do
    CSV.foreach(File.expand_path("BusData/combinedData/stops.csv"), :headers=>true) do |row|
      Stop.create!(row.to_hash)
    end
  end
  task :create_trips => :environment do
    CSV.foreach(File.expand_path("BusData/combinedData/trips.csv"), :headers=>true) do |row|
      Trip.create!(row.to_hash)
    end
  end
end 
