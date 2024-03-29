require 'rails_helper'
include RandomData

RSpec.describe User, type: :model do
	#let(:user) { User.create!(name: "bloccit user", email: "user@bloccit.com", password: "password") }
	let(:user) { create(:user)}
	# shoulda tests for name
	it {should validate_presence_of(:name)}
	it {should validate_length_of(:name).is_at_least(1)}
	it {should have_many(:posts)}
	it {should have_many(:comments)}
	it {should have_many(:votes)}
	it {should have_many(:favorites)}

	#should tests for email
	it {should validate_presence_of(:email)}
	it {should validate_uniqueness_of(:email)}
	it {should validate_length_of(:email).is_at_least(3)}
	it {should allow_value("user@bloccit.com").for(:email)}
	it {should_not allow_value("userloccit.com").for(:email)}

	# should tests for password
	it {should validate_presence_of(:password)}
	it {should have_secure_password}
	it {should validate_length_of(:password).is_at_least(6)}

	describe "attributes" do
		it "should respond to name" do
			expect(user).to respond_to(:name)
		end

		it "should respond to email" do
			expect(user).to respond_to(:email)
		end

		it "should respond to role" do 
			expect(user).to respond_to(:role)
		end

		it "should respond to admin?" do
			expect(user).to respond_to(:admin?)
		end

		it "should respond to member?" do
			expect(user).to respond_to(:member?)
		end
	end

	describe "roles" do 
		it "should be member by default" do
			expect(user.role).to eq("member")
		end
	end

	# use ActiveRecord::Enum
	context "member user" do 
		it "should return true for #member" do 
			expect(user.member?).to be_truthy
		end

	    it "should return false for #admin?" do 
	    	expect(user.admin?).to be_falsey
	    end
	end

	context "admin user" do 
		before do 
			user.admin!
		end

		it "should return false for #member" do 
			expect(user.member?).to be_falsey
		end

		it "should return false for #admin?" do 
			expect(user.admin?).to be_truthy
		end
	end

	describe "invalid user" do
		# let(:user_with_invalid_name){ User.new(name: "", email: 'user@bloccit.com')}
		# let(:user_with_invalid_email){ User.new(name: "Junko", email: "")}
		# let(:user_with_invalid_format) {User.new(name: "junko user", email: "invalid_email")}
		let(:user_with_invalid_name){ build(:user, name: "")}
		let(:user_with_invalid_email){ build(:user, email: "")}
		let(:user_with_invalid_format){ build(:user, email: "invalid_email") }
		let(:user_name_capitalized){ User.create!(name: "junko block", email: 'user@bloccit.com', password: "password")}
		
		it "should be an invalid user due to blank name" do
			expect(user_with_invalid_name).to_not be_valid
		end

		it "should be an invalid user due to blank email" do 
			expect(user_with_invalid_email).to_not be_valid
		end

		it "should be a invalid user due to invalid email format" do
			expect(user_with_invalid_format).to_not be_valid
		end

		it " should format name to capitalized form" do
			expect(user_name_capitalized.name).to eq("Junko Block")
		end
	end

	describe "#favorite_for(post)" do
		before do
			topic = Topic.create(name: RandomData.random_sentence, description: RandomData.random_paragraph)
			@post = topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user)
		end

		it "returns nil if the user has not favorited the post" do 
			expect(user.favorite_for(@post)).to be_nil
		end

		it "returns the appropriate favorite if it exists" do 
			favorite = user.favorites.where(post: @post).create
			expect(user.favorite_for(@post)).to eq(favorite)

		end
	end

	describe ".avatar_url" do  # . (or ::) when referring to a class method's name and # when referring to an instance method's name
		# we build a user with FactoryGirl and overwrite the default email
		let(:know_user) { create(:user, email: "blochead@bloc.io")}
		it "returns the proper Gravatar url for a know email entity" do 
			expected_avatar = "http://gravatar.com/avatar/bb6d1172212c180cfbdb7039129d7b03.png?s=48"
			#  the returned image to be 48x48 pixels
			expect(know_user.avatar_url(48)).to eq(expected_avatar)

		end
	end

	describe "#generate_auth_token" do 
		it "creates a token" do 
			expect(user.auth_token).to_not be_nil

		end
	end

end
