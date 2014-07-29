require 'digest/md5'

class User < ActiveRecord::Base
	has_secure_password
	before_validation :prep_email
	before_save :create_avatar_url

	validates :email, presence: true,
		uniqueness: true,
		format: {with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9\.-]+\.[A-Za-z]+\Z/}
	validates :username, presence: true,
		uniqueness: true
	validates :name, presence: true

	private

	def prep_email
		self.email = self.email.strip.downcase if self.email
	end

	def create_avatar_url
		self.avatar_url = "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(self.email)}?s=50"
	end

end
