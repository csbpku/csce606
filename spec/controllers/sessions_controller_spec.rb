require 'rails_helper'

RSpec.describe SessionsController do
    describe "create session for user with no response" do
        it "Successfully create a session for user once login is completed with no response" do
            get :create
            expect(response).to redirect_to(root_path)
        end
    end
end