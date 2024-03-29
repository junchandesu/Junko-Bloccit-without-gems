require 'rails_helper'
include RandomData
include SessionsHelper

RSpec.describe FavoritesController, type: :controller do
   let(:my_user) { User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld") }
   let(:my_topic) { Topic.create!(name:  RandomData.random_sentence, description: RandomData.random_paragraph) }
   let(:my_post) { my_topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: my_user) }
 
 	context "guest user" do 
 		describe "POST create" do 
 			it "direct user to the sign-in page" do 
 			 post :create, {post_id: my_post.id}
 			 expect(response).to redirect_to(new_session_path)
 		    end
 		end

 		describe "Delete destroy" do 
 			it "redirect user to the sign_in page" do 
 			  favorite = my_user.favorites.where(post: my_post).create
 			  delete :destroy, {post_id: my_post.id, id: favorite}
 			  expect(response).to redirect_to(new_session_path)
 			end	

 		end
 	end

 	context "signed-in user" do 
 		before do
 			create_session(my_user)
 		end
 		describe "POST create" do 
 			it "redirect to the posts show view" do 
 				post :create, { post_id: my_post.id}
 				expect(response).to redirect_to([my_topic, my_post])
 			end

 			it "creates a favorites for the post and current_user" do 
 				expect(my_user.favorites.find_by_post_id(my_post.id)).to be_nil
 				post :create, {post_id: my_post.id}
 				expect(my_user.favorites.find_by_post_id(my_post.id)).not_to be_nil
 			end
 		end

 		describe "DELETE destroy" do 
 			it "redirect to the posts show view" do
 				favorite = my_user.favorites.where(post: my_post).create
 				delete :destroy, {post_id: my_post.id, id: favorite}
 				expect(response).to redirect_to([my_topic, my_post])
 			end

 			it "destroys the favorite for the current_user and post" do
 			    favorite = my_user.favorites.where(post: my_post).create
 			    expect(my_user.favorites.find_by_post_id(my_post.id)).not_to be_nil
 			    delete :destroy, {post_id: my_post.id, id: favorite}
 			    expect(my_user.favorites.find_by_post_id(my_post.id)).to be_nil
			end
 		end
 	end
end
