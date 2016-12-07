require 'rails_helper'

RSpec.describe SessionsController do
    describe "create session for user with no response" do
        it "Successfully create a session for user once login is completed with no response" do
            get :create
            expect(response).to redirect_to(root_path)
        end
    end
    describe "create session for user" do
        it "Successfully create a session for user once login is completed" do
            request.env['omniauth.auth'] = {'uid' => 1, 'provider' => 'facebook', 'info' => {'name' => 'xyz', 'location' => 'abs', 'image' =>'', 'urls' => 'wwww'}}
            get :create
            expect(response).to redirect_to(root_path)
        end
    end
    
    describe "#destroy" do
        it "should clear the session" do
            request.env['omniauth.auth'] = {'uid' => 1, 'provider' => 'facebook', 'info' => {'name' => 'xyz', 'location' => 'abs', 'image' =>'', 'urls' => 'wwww'}}
            post :create
            session[:user_id].should_not be_nil
            delete :destroy
            session[:user_id].should be_nil
        end
    end
    
    describe "after session destroy redirect link to home page" do
        it "should redirect to the home page" do
            request.env['omniauth.auth'] = {'uid' => 1, 'provider' => 'facebook', 'info' => {'name' => 'xyz', 'location' => 'abs', 'image' =>'', 'urls' => 'wwww'}}
            post :create
            delete :destroy
            expect(response).to redirect_to root_path
        end
    end
end