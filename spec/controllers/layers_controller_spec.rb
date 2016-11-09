require 'rails_helper'

RSpec.describe LayersController, type: :controller do
    describe "Get data for buildings" do
        it "Successfully return building object if params exist" do
            get :dropPins, {:layer => {:building => '1'}}
            expect(response.body).to eq("{\"layer\":[{\"objtype\":\"Building\",\"points\":[]}]}") 
        end
    end
    
    describe "Get data for car parking" do
        it "Successfully return car parking object if params exist" do
            get :dropPins, {:layer => {:parking => '1'}}
            expect(response.body).to eq("{\"layer\":[{\"objtype\":\"Parking\",\"points\":[]}]}") 
        end
    end

end
