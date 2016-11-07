class LayersController < ApplicationController
    def dropPins
        
        @position = Buildings.all
        @position = @position.as_json
       # @buildings = {"objtype"=>"Building","points"=>[{"lan"=>30.6187199,"lon"=>-96.3364829},{"lan"=>30.616842,"lon"=>-96.339240}]}
        @buildings = {"objtype"=>"Building","points"=> @position}
        if params["layer"]["building"]
             render json: @buildings
        end
    end
    
end
