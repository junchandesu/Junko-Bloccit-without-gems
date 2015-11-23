require 'rails_helper'
include RandomData

RSpec.describe PostsController, type: :controller do  #allows us to simulate a controller actions such as HTTP requests

  let (:my_post) { Post.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph) }

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    # it "assigns [my_post] to @posts" do
    #    get :index
    #    expect(assigns(:posts)).to eq([my_post])
    #  end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, {id: my_post.id}  # hese parameters are passed to the params hash
      # Passes if response has a matching HTTP status code.
      # checks for a response code of 200 which is the standard HTTP response code for success
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      get :show, {id: my_post.id}
      expect(response).to render_template(:show)
    end

    it "assigns my_post to @post" do 
      get :show, {id:my_post.id}
      expect(assigns(:post)).to eq(my_post)
    end

  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders the #new view" do
      get :new
      expect(response).to render_template :new
    end

    it "assigns the new post to post @post" do
      get :new
      expect(assigns(:post)).not_to be_nil
    end

  end

  describe "POST #create" do
    it "increases the number of POST by 1" do
      expect{post :create, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}}.to change(Post, :count).by(1)
    end

    it "assings a new post to @post" do
      post :create, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
      expect(assigns(:post)).to eq Post.last
    end

    it "directs to the last post" do
      post :create, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
      expect(response).to redirect_to Post.last
    end

  end

  describe "GET #edit" do
    it "returns http success" do
      get :eit, {id: my_post.id}
      expect(response).to have_http_status(:success)
    end

    it "renders the #edit view" do
      get :edit, {id:my_post.id}
      expect(response).to render_template(:edit)
    end

    it "assigns post to be updated to @post" do
      get :edit, {id: my_post.id}
      post_instance = assigns(:post)
      expect(post_instance.id).to eq(my_post.id)
      expect(post_instance.title).to eq(my_post.title)
      expect(post_instance.body).to eq(my_post.body)
    end
  end

  describe "PUT update" do 
    it "updates post with expectd attributes" do 
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph
      put :update, id: my_post.id, post: { title: new_title, body: new_body}
      updated_post = assigns(:post)
      expect(updated_post.id).to eq(my_post.id)
      expect(updated_post.title).to eq(new_title)
      expect(updated_post.body).to eq(new_body)
    end

    it "redirects to the updated post" do 
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph
      put :update, id: my_post.id, post: { title: new_title, body: new_body}
      expect(response).to redirect_to my_post
    end

  end

  describe "DELETE destroy" do 
    it "delete the post" do
      delete :destroy, {id: my_post.id}
      count = Post.where(id: my_post.id).size
      expect(count).to eq 0
    end

    it "redirects to posts index" do
      delete :destroy, {id: my_post.id}
      expect(response).to redirect_to posts_path  #edirected to the posts index view 
    end

  end

end
