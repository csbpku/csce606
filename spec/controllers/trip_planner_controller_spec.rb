require "rails_helper"

RSpec.describe TripPlannerController, :type => :controller  do
  describe "Get coordinate from address" do
    it "Sucessfully converts a string address to geolocations" do
      expect(controller.address_to_coordinates("HRBB")).to eq([30.6189722, -96.3387678])
    end
  end
  
  describe "Find the nearest bus stop given a location" do
    it "Finds the nearest stop" do
      expect(controller.find_nearest_stop([30.6189722, -96.3387678]).code).to eq(416)
    end
  end
  
  describe "Find the walking path from one palce to another" do
    it "Finds the walking path" do
<<<<<<< HEAD
=======
      expect(controller.walking_route([30.619748, -96.33873], [30.6177768, -96.338907])).not_to be_empty
    end
  end
  
  describe "Find routes that all have the same stop" do
    it "Finds the correct routes" do
      expect(controller.find_routes_set_by_stop(Stop.find(1))[0].id).to eq(10)
>>>>>>> origin/dev
    end
  end
end