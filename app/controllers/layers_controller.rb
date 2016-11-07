class LayersController < ApplicationController
    
    def select_building
        @buildings = Buildings.all
    end
    
    def select_car
        @cars = Cars.all
    end
    
end
