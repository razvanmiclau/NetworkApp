require 'digest/md5'

class User < ActiveRecord::Base
	has_secure_password
	has_many :statuses

	has_many :follower_friendships, class_name: 'Friendship', foreign_key: 'followed_id'
	has_many :followed_friendships, class_name: 'Friendship', foreign_key: 'follower_id'
	has_many :followers, through: :follower_friendships
	has_many :followeds, through: :followed_friendships

	before_validation :prep_email
	before_save :create_avatar_url

	validates :email, presence: true,
		uniqueness: true,
		format: {with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9\.-]+\.[A-Za-z]+\Z/}
	validates :username, presence: true,
		uniqueness: true
	validates :name, presence: true

	def following? user
		self.followeds.include? user
	end

	def follow user
		Friendship.create follower_id: self.id, followed_id: user.id
	end

	private

	def prep_email
		self.email = self.email.strip.downcase if self.email
	end

	def create_avatar_url
		self.avatar_url = "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(self.email)}?s=50"
	end

end
