require 'rails_helper'
include RandomData

RSpec.describe Topic, type: :model do
  # let(:my_topic) {Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }
  let(:my_topic) { create(:topic)}
  # shoulda
  it { should have_many(:posts)}
  it { should have_many(:labelings)}
  it { should have_many(:labels).through(:labelings)}
  describe "attributes" do 
  	it "should respond to name" do 
  	  expect(my_topic).to respond_to(:name)
    end

    it "should respond to description" do
    	expect(my_topic).to respond_to(:description)
    end

    it "should respond to public" do
    	expect(my_topic).to respond_to(:public)
    end

    it "should be public by default" do 
    	expect(my_topic.public).to be true
    end
  end
end
