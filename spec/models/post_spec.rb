require 'rails_helper'
include RandomData
RSpec.describe Post, type: :model do
  # let(:topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph)}
  # let(:user) { User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld") }
  # let(:post) { topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user)}
  let(:topic) { create(:topic)}
  let(:user) { create(:user)}
  let(:post) { create(:post)}
  it {should belong_to(:topic)}
  it {should belong_to(:user)}
  it {should have_many(:comments)}
  it {should have_many(:votes)}
  it {should have_many(:favorites)}
  it {should validate_presence_of(:title)}
  it {should validate_presence_of(:body)}
  it {should validate_presence_of(:topic)}
  it {should validate_presence_of(:user)}
  it {should validate_length_of(:title).is_at_least(5) }
  it {should validate_length_of(:body).is_at_least(20)}

  describe "attributes" do 
  	it "should respond to title" do
  		expect(post).to respond_to(:title)
  	end

  	it "should respond to body" do 
  		expect(post).to respond_to(:body)
  	end
  end
  
  describe "voting" do
   before do
    2.times {post.votes.create!(value: 1)}
    3.times {post.votes.create!(value: -1)}
    @up_votes = post.votes.where(value: 1).count
    @down_votes = post.votes.where(value: -1).count
   end

   describe "#up_votes" do
    it "counts the number of votes with value 1" do
      expect(post.up_votes).to eq(@up_votes)
    end
   end

   describe "#down_votes" do
    it "counts the number of votes with value -1" do
      expect(post.down_votes).to eq @down_votes
    end
   end

   describe "#points" do
    it "returns the sume of all downs and ups" do
      expect(post.points).to eq(@up_votes - @down_votes)
    end 
   end

   describe "#update_link" do 
    it "calculates the correct rank" do 
      post.update_rank
      expect(post.rank).to eq(post.points + (post.created_at - Time.new(1970,1,1)) / 1.day.seconds)
      # Determine the age of the post by subtracting a standard time(epoch) from its created_at time. 
    end

    it "updates the rank when an up vote is created" do
      old_rank = post.rank
      post.votes.create!(value: 1)
      expect(post.rank).to eq(old_rank + 1)
    end

    it "updates the rank when a down vote is created" do 
      old_rank = post.rank
      post.votes.create!(value: -1)
      expect(post.rank).to eq(old_rank - 1)
      # Add the points (i.e. sum of the votes) to the age. This means that the passing of one day will be equivalent to one down vote
    end
   end
  end

   describe "#create_vote is called after post is created" do 
     it "create the vote one" do
      expect(Vote.where(post_id: post.id).first.value).to eq(1)

     end  
    end
end

