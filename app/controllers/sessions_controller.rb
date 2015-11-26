class SessionsController < ApplicationController

	def new

	end

	def create
		# we search the database for a user with the specified email address
		user = User.find_by(email: params[:session][:email].downcase)
		# verify that user is not nil and that the password in the params hash matches the specified password.
		if user && user.authenticate(params[:session][:password])
			create_session user  # goes method to helper method for session controller
			flash[:notice] = "Welcome, #{user.name}!"
			redirect_to root_path
		else
			flash[:error] = 'Invalid email/password confirmation'
			render :new
		end
	end

	def destroy
			destroy_session(current_user)
			flash[:notice] = "You've been signed out. Come back!"
			redirect_to root_path
	end
end
