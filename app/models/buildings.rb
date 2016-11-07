class Buildings < ActiveRecord::Base
    
    def self.getLocations
        self.select(:lan, :lon).map(&:building_location)
    end
    
end