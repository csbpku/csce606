class LayersController < ApplicationController
    
    def dropPins
        @build_pos = Buildings.all
        @build_pos = @build_pos.as_json()
        @buildings = {"objtype"=>"Building","points"=> @build_pos}
        
        @car_pos = Cars.all
        @car_pos = @car_pos.as_json()
        @cars = {"objtype"=>"Parking","points"=> [{"lan"=>30.6187199,"lon"=>-96.3364829},{"lan"=>30.616842,"lon"=>-96.339240}]}
        
        if params["layer"]["building"]
            render json: @buildings
        #elif params["layer"]["parking"]
         #   render json: @cars
        end
    end
end
