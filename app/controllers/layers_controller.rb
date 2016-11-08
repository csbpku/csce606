class LayersController < ApplicationController
    
    def dropPins
        
        if params["layer"]["building"]
            #render json: @buildings and return
            @build_pos = Buildings.all
            @build_pos = @build_pos.as_json()
            @buildings = {"objtype"=>"Building","points"=> @build_pos}
        end
        if params["layer"]["bicycle"]
             @bike_pos = Bikes.all
            @bike_pos = @bike_pos.as_json()
            @bikeracks = {"objtype"=>"Bikes","points"=> @bike_pos}
        end
        
        render json: {bikes:@bikeracks,buildings:@buildings}
        
    end
end