require 'rails_helper'

RSpec.describe Api::V1::BaseController, type: :controller do 
	let(:my_user) { create(:user)}

	context "authorized user" do 
		before do 
			# set an HTTP header named HTTP_AUTHORIZATION in our request to the user's auth_token in order for our requests to work properly with the API
			controller.request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(my_user.auth_token)
			# authenticate_user finds the user by the specified token 
			controller.authenticate_user
		end

		describe "#authenticate_user" do 
			it "find a user by their authentication token" do
				expect(assigns(:current_user)).to eq(my_user)
			end
		end

	end
end

