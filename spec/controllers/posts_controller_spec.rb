require 'rails_helper'
include RandomData

RSpec.describe PostsController, type: :controller do  #allows us to simulate a controller actions such as HTTP requests

  let (:my_post) { Post.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph) }

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns [my_post] to @posts" do
       get :index
 # #9
       expect(assigns(:posts)).to eq([my_post])
     end
  end

  # describe "GET #show" do
  #   it "returns http success" do
  #     get :show
  #     # Passes if response has a matching HTTP status code.
  #     # checks for a response code of 200 which is the standard HTTP response code for success
  #     expect(response).to have_http_status(:success)

  #   end
  # end

  # describe "GET #new" do
  #   it "returns http success" do
  #     get :new
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET #edit" do
  #   it "returns http success" do
  #     get :eit
  #     expect(response).to have_http_status(:success)
  #   end
  # end



end
