class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation
	acts_as_authentic
	has_many :desires,  dependent: :destroy

	def feed
		Desire.where("user_id = ?", self)
	end
end
