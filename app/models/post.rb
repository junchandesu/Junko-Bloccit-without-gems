class Post < ActiveRecord::Base
	belongs_to :topic
	belongs_to :user
	has_many :comments, dependent: :destroy
	has_many :labelings, as: :labelable
	has_many :labels, through: :labelings
	has_many :votes, dependent: :destroy
	has_many :favorites, dependent: :destroy

	after_create :create_vote

	validates :title, length: {minimum:5}, presence: true
	validates :body, length: {minimum:20}, presence: true
	validates :topic, presence: true
	validates :user, presence: true

	default_scope{ order('created_at DESC')}
	default_scope{ order('rank DESC')}
	# a lambda (->) to ensure the condition(signed in or not) and Active Record joins method to retrieve all posts which belong to a public topic
	scope :visible_to, -> (user) { user ? all : joins(:topic).where('topics.public' => true)}
	scope :ordered_by_title, ->{ order 'title'}
	scope :ordered_by_reverse_created_at, -> { order('created_at ASC')}

	def up_votes
		votes.where(value: 1).count
	end

	def down_votes
		votes.where(value: -1).count
	end

	def points
		votes.sum(:value)
	end

	def update_rank
		age_in_days = (created_at - Time.new(1970,1,1))/1.days.seconds
		new_rank = points + age_in_days
		update_attribute(:rank, new_rank)
	end

	private
	def create_vote
		user.votes.create(value: 1, post: self)
	end
end
