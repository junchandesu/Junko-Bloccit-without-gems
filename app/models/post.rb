class Post < ActiveRecord::Base
	belongs_to :topic
	belongs_to :user
	has_many :comments, dependent: :destroy
	has_many :labelings, as: :labelable
	has_many :labels, through: :labelings

	validates :title, length: {minimum:5}, presence: true
	validates :body, length: {minimum:20}, presence: true
	validates :topic, presence: true
	validates :user, presence: true

	default_scope{ order('created_at DESC')}
	scope :ordered_by_title, ->{ order 'title'}
	scope :ordered_by_reverse_created_at, -> { order('created_at ASC')}

end
