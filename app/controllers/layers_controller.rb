class LayersController < ApplicationController
    def dropPins
        @buildings = {"objtype"=>"Building","points"=>[{"lat"=>30.6187199,"lon"=>-96.3364829},{"lat"=>30.616842,"lon"=>-96.339240}]}
        if params["layer"]["building"]
             render json: @buildings
        end
    end
    
end
