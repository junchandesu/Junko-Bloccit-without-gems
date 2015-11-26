module SessionsHelper
	# session is an object Rails provides to track the state of a particular user. a one-to-one relationship between session objects and user ids
	def create_session(user)
		session[:user_id] = user.id
	end

	def destroy_session(user)
		session[:user_id] = nil
	end

	def current_user
		User.find_by(id: session[:user_id])
	end
end
