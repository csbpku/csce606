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
      
end