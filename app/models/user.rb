class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation, :avatar
	acts_as_authentic do |c|
    c.logged_in_timeout = 10.minutes # default is 10.minutes
  end
  has_attached_file :avatar, 
                    storage: :dropbox,
                    dropbox_credentials: "#{Rails.root}/config/dropbox.yml",
                    styles: { medium: "150x150>", thumb: "52x52>", small: "40x40>" },
                    dropbox_options: {
                        path: proc { |style| "venti5sera/#{style}/#{id}_#{avatar.original_filename}" },
                        unique_filename: true
                    }

  validates_attachment_size :avatar, less_than: 500.kilobyte
	has_many :desires,  dependent: :destroy
	has_one :relationship, foreign_key: "follower_id", dependent: :destroy
  has_one :followed_user, through: :relationship, source: :followed

  has_one :reverse_relationship, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_one :follower, through: :reverse_relationship, source: :follower

  validate :max_users

  default_scope order: 'users.name'

	def feed
		Desire.where("user_id = ?", self)
	end

	def following?(other_user)
		# The force_reload is to avoid caching problems
    relationship(force_reload = true) && followed_user == other_user
  end

  def follow!(other_user)
    create_relationship!(followed_id: other_user.id) unless other_user.follower
  end

  def unfollow!(other_user)
    relationship.destroy
  end

  def self.search(search)
    if search
      _users = User.arel_table
      User.where(_users[:name].matches("%#{search}%"))
    else
      find(:all)
    end
  end

  def max_users
    errors.add(:max_users, "reached") if User.all.count >= ENV["MAX_USERS"].to_i
  end

end
