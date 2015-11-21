class PostsController < ApplicationController
  def index
  	@posts = Post.all
  	# evey 5th post is replaced with "SPAM" except for 0 index
  	@posts.each_with_index do |post, index|
  		post.title = "SPAM" if index % 5 == 0 && index != 0
  	end
  end

  def show
  end

  def new
  end

  def edit
  end
end
