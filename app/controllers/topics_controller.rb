class TopicsController < ApplicationController
	before_action :require_sign_in, except: [:index, :show]
	before_action :authorize_user, except: [:index, :show]

	def index
		@topics = Topic.visible_to(current_user)
	end

	def show
		@topic = Topic.find(params[:id])
		unless @topic.public || current_user
			flash[:error] = "You must sign in to view private topics" 
			redirect_to new_session_path
		end
	end
	
	def new
		@topic = Topic.new
	end

	def create
		# @topic = Topic.new
		# @topic.name = params[:topic][:name]
		# @topic.description = params[:topic][:description]
		# @topic.public = params[:topic][:public]
		@topic = Topic.new(topic_params)
		if @topic.save
			@topic.labels = Label.update_labels(params[:topic][:labels])
			redirect_to @topic, notice: "Topic was saved successfully."
		else
			flash[:error]= "Error creating topic. Please try again"
			render :new
		end
	end

	def edit
		@topic = Topic.find(params[:id])
	end	

	def update
		@topic = Topic.find(params[:id])
		# @topic.name = params[:topic][:name]
		# @topic.description = params[:topic][:description]
		# @topic.public = params[:topic][:public]
		@topic.assign_attributes(topic_params)
		if @topic.save
			@topic.labels = Label.update_labels(params[:topic][:labels])
			redirect_to @topic, notice: "Topic was updated."
		else
			flash[:error] = "Error updating topic."
			render :edit
		end
	end	

	def destroy
		@topic = Topic.find(params[:id])
		if @topic. destroy
			flash[:notice]= "#{@topic.name} is deleted successfully."
			redirect_to action: :index
		else
			flash[:error] = "Error deleting topic."
			drender :show		
		end

	end

	private
	# mass-assignment, strong parameters
	def topic_params
		params.require(:topic).permit(:name, :description, :public)
	end

	def authorize_user
		unless current_user.admin?
			redirect_to topics_path
		end
	end

end
