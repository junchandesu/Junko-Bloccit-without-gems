class CommentsController < ApplicationController
	before_action :require_sign_in
	before_action :authorize_user, only: [:destroy]

	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.new(comment_params)
		@comment.user = current_user
		@new_comment = Comment.new
		if @comment.save
			flash[:notice] = "Comment was saved successfully."
			# redirect_to [@post.topic, @post]
		else
			flash[:error] = "Comment failed to save."
			# redirect_to [@post.topic, @post]
		end

		respond_to do |format|
			format.html
			format.js
		end

	end

	def destroy
		@post = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id])
		if @comment.destroy
			flash[:notice] = "Comment was deleted"
			# redirect_to [@post.topic, @post]
		else
			flash[:error] = "Comment could not be deleted. Please try again."
			# redirect_to [@post.topic, @post]
		end

		respond_to do |format|
			format.html
			format.js
		end
	end

	private

	def comment_params
		params.require(:comment).permit(:body)
	end

	def authorize_user
		comment = Comment.find(params[:id])
		unless current_user == comment.user || current_user.admin?
			flash[:error] = "You do not have permission to delete this comments."
			redirect_to [comment.post.topic, comment.post]
		end
	end
end
