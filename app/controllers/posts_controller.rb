class PostsController < ApplicationController
  def index
  	@posts = Post.all
  	# evey 5th post is replaced with "SPAM" except for 0 index
  	@posts.each_with_index do |post, index|
  		post.title = "SPAM" if index % 5 == 0 && index != 0
  	end
  end

  def show
  	@post = Post.find(params[:id])
  end

  def new
  	@post = Post.new
  end
 
  def create
  	@post = Post.new
  	@post.title = params[:post][:title]
  	@post.body = params[:post][:body]
  	if @post.save
  		flash[:notice] = "Post was saved."
  		redirect_to @post
  	else
  		flash[:error] = "There was an error posting. Please try again."
  		render :new
  	end
  end

  def edit
  end
end
