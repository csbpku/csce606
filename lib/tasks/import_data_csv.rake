require 'csv'
namespace :import_data_csv do
  task :create_buildings_position => :environment do
    CSV.foreach(File.expand_path("Data/building.csv"), :headers=>true) do |row|
      Buildings.create!(row.to_hash)
    end
  end
end