class PostsController < ApplicationController
  before_action :require_sign_in, except: :show
  
  # def index
  # 	@posts = Post.all
  # 	# evey 5th post is replaced with "SPAM" except for 0 index
  # 	@posts.each_with_index do |post, index|
  # 		post.title = "SPAM" if index % 5 == 0 && index != 0
  # 	end
  # end


  def show
  	@post = Post.find(params[:id])
  end

  def new
    @topic = Topic.find(params[:topic_id])
  	@post = Post.new
  end
 
  def create
  	# @post = Post.new(post_params)
  	# @post.title = params[:post][:title]
  	# @post.body = params[:post][:body]
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.build(post_params)
    @post.user = current_user
  	if @post.save
  		flash[:notice] = "Post was saved."
  		redirect_to [@topic, @post]
  	else
  		flash[:error] = "There was an error posting. Please try again."
  		render :new
  	end
  end

  def edit
  	@post = Post.find(params[:id])
  end

  def update
  	@post = Post.find(params[:id])
  	# @post.title = params[:post][:title]
  	# @post.body = params[:post][:body]
  	@post.assign_attributes(post_params)
    if @post.save
  		flash[:notice] = "Post was updated."
  		redirect_to [@post.topic, @post]
  	else
  		flash[:error] = "There was an error updating the post. Please try again"
  		render :edit
  	end
  end

  def destroy
  	@post = Post.find(params[:id])
  	if @post.destroy
  		flash[:notice] = "Post #{@post.title} was deleted successfully."
  		redirect_to @post.topic
  	else
  		flash[:error] = "There was an error deleting the post."
  		redirect_to @post
  	end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
