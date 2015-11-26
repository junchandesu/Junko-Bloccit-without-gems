require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

	let(:my_user) { User.create!(name: "Blochead", email: "Blockhead@bloc.id", password: "password")}

	describe "GET new" do
		it "returns the http success" do
			get :new
			expect(response).to have_http_status(:success)
		end
	end

	describe "POST sessions" do
		it "returns http success" do
			post :create, session: { email: my_user.email}
			expect(response).to have_http_status(:success)
		end
	
		it "initialize a session" do
			post :create, session: {email: my_user.email, password: my_user.password}
			expect(session[:user_id]).to eq(my_user.id)
		end

		it "does not add a user id due to the missing password" do
			post :create, session: {email:my_user.id}
			expect(session[:user_id]).to be_nil
		end

		it "flashes #error with a invalid email" do
			post :create, session: {email: "invalid email"}
			expect(flash[:error]).to be_present
		end

		it "renders #new with an invalid email" do
			post :create, session: { email: "invalid email"}
			expect(response).to render_template :new
		end

		it "redirects to root view" do 
			post :create, session: {email: my_user.email, password: my_user.password}
			expect(response).to redirect_to root_path
		end
	end

	describe "DELETE sessions/id" do 
		it "render the #welcome view page" do
			delete :destroy, id: my_user.id
			expect(response).to redirect_to root_path
		end

		it "delete the user's session id" do
			delete :destroy, id: my_user.id
			expect(assigns(:session)).to be_nil
		end

		it "flashes #notice" do
			delete :destroy, id: my_user.id
			expect(flash[:notice]).to be_present
		end

	end

end
