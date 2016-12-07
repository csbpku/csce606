require 'rails_helper'

RSpec.describe User do
    it 'Successfully resturn user details on login' do
        dummy = {'uid' => 1, 'provider' => 'facebook', 'info' => {'name' => 'xyz', 'location' => 'abs', 'image' =>'', 'urls' => 'wwww'}}
        result = User.from_omniauth(dummy)
        expect(result.uid).to eq("1")
    end
end
