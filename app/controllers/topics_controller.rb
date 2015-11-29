class TopicsController < ApplicationController

	def index
		@topics = Topic.all
	end

	def show
		@topic = Topic.find(params[:id])
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

end
