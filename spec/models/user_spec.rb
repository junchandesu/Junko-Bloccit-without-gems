require 'rails_helper'

RSpec.describe User, type: :model do
	let(:user) { User.create!(name: "bloccit user", email: "user@bloccit.com", password: "password") }
	# shoulda tests for name
	it {should validate_presence_of(:name)}
	it {should validate_length_of(:name).is_at_least(1)}


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
	end

	describe "invalid user" do
		let(:user_with_invalid_name){ User.new(name: "", email: 'user@bloccit.com')}
		let(:user_with_invalid_email){ User.new(name: "Junko", email: "")}
		let(:user_with_invalid_format) {User.new(name: "junko user", email: "invalid_email")}
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
end
