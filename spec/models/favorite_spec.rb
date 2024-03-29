require 'rails_helper'
include RandomData
include SessionsHelper

RSpec.describe Favorite, type: :model do
   # let(:topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }
   # let(:user) { User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld") }
   # let(:post) { topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user) }
   let(:topic) { create(:topic)}
   let(:user) { create(:user)}
   let(:post) { create(:post)}
   let(:favorite) {Favirate.create!(user: user, post: post)}

   it {should belong_to(:post)}
   it {should belong_to(:user)}

end
