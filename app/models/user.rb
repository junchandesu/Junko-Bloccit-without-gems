class User < ActiveRecord::Base
	has_many :posts, dependent: :destroy
	has_many :comments, dependent: :destroy
	has_many :votes, dependent: :destroy
	# will run when the callback executes
	before_save { self.email = email.downcase }
	before_save {self.role ||= :member }
	before_save :format_name
	EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates :name, length: { minimum: 1, maximum: 100 }, presence: true
	# ensures that when we create a new user, they have a valid password
	validates :password, presence: true, length: { minimum: 6 }, if: "password_digest.nil?"
	# allow_blank: true skips the validation if no updated password is given.
	#  This allows us to change other attributes on a user without being forced to set the password
	validates :password, length: { minimum: 6 }, allow_blank: true
	validates :email, 
			  presence: true,
			  uniqueness: {case_sensitive: false},
			  length: { minimum: 3, maximum: 100 },
			  format: { with: EMAIL_REGEX }
	# Adds methods to set and authenticate against a BCrypt password. This mechanism requires you to have a password_digest attribute.
	# has_secure_password requires a password_digest attribute on the model it is applied to.
	# creates two virtual attributes, password and password_confirmation that we use to set and save the password
	has_secure_password
	# Role.roles show below.
	enum role: [:member, :admin]

	private
	def format_name
		if name
		 self.name = name.split(" ").map(&:capitalize).join(" ")
    	end 
    end
end
