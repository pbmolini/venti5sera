class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation
	acts_as_authentic
	has_many :desires,  dependent: :destroy
	has_one :relationship, foreign_key: "follower_id", dependent: :destroy
  has_one :followed_user, through: :relationship, source: :followed

  has_one :reverse_relationship, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_one :follower, through: :reverse_relationship, source: :follower

	def feed
		Desire.where("user_id = ?", self)
	end

	def following?(other_user)
		# The force_reload is to avoid caching problems
    relationship(force_reload = true) && followed_user == other_user
  end

  def follow!(other_user)
    create_relationship!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationship.destroy
  end

end
