require 'rails_helper'

RSpec.describe User do
    it 'Successfully resturn user details on login' do
        dummy = {'uid' => 1, 'provider' => 'facebook', 'info' => {'name' => 'xyz', 'location' => 'abs', 'image' =>'', 'urls' => 'wwww'}}
        result = User.from_omniauth(dummy)
        expect(result.uid).to eq("1")
    end
    
    it 'Return url of selected provider' do
        dummy = {'uid' => 1, 'provider' => 'linkedin', 'info' => {'name' => 'xyz', 'location' => 'abs', 'image' =>'', 'urls' => {'public_profile' => 'www'}}}
        result = User.get_social_url_for('linkedin', dummy['info']['urls'])
        expect(result).to eq(nil)
    end
    
end
