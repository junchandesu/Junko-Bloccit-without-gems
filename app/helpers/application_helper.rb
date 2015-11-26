module ApplicationHelper
	#  Any public method we write in ApplicationHelper will be available in all views.

	def form_group_tag(errors, &block)
		# The & turns the block into a Proc, a block that can be reused like a variable.
		if errors.any?
			content_tag :div, capture(&block), class: 'form-group has-error'
		else
			content_tag :div, capture(&block), class: 'form-group'
		end
	end

	def avatar_url(user)
		gravatar_id = Digest::MD5::hexdigest(user.email).downcase
        "http://gravatar.com/avatar/#{gravatar_id}.png?s=48"
  	end
end
