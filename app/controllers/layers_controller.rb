class LayersController < ApplicationController
    def dropPins
        
        @position = Buildings.all
        @position = @position.as_json()
        @buildings = {"objtype"=>"Building","points"=> @position}
        if params["layer"]["building"]
             render json: @buildings
        end
    end
    
end
