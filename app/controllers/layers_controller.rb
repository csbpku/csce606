class LayersController < ApplicationController
    
    def dropPins
        @res = Hash.new
        @res["layer"] = Array.new
        
        if params["layer"]["building"]
            #render json: @buildings and return
            @build_pos = Buildings.all
            @build_pos = @build_pos.as_json()
            @buildings = {"objtype"=>"Building","points"=> @build_pos}
            @res["layer"].push(@buildings)
        end
        if params["layer"]["bicycle"]
             @bike_pos = Bikes.all
            @bike_pos = @bike_pos.as_json()
            @bikeracks = {"objtype"=>"Bikes","points"=> @bike_pos}
            @res["layer"].push(@bikeracks)
            
        end
        
        if params["layer"]["parking"]
            @car_pos = Cars.all
            @car_pos = @car_pos.as_json()
            @cars = {"objtype"=>"Parking","points"=> @car_pos}
            @res["layer"].push(@cars)
        end
        
        render json: @res
        
    end
end