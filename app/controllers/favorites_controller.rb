class FavoritesController < ApplicationController
	before_action :require_sign_in

	def create
		post = Post.find(params[:post_id])
		favorite = current_user.favorites.create(post: post)
		if favorite.save
			flash[:notice] = "Post favorite."
		else
			flash[:error] = "Favoriting failed"
		end
		redirect_to [post.topic, post]
	end

	def destroy
		post = Post.find(params[:post_id])
		favorite = current_user.favorites.find(params[:id])
		if favorite.destroy
			flash[:notice] = "Post unfavorite "
		else
			flash[:error] = "Unfavorite failed"
		end
		redirect_to [post.topic, post]

	end

	
end
