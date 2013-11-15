class Desire < ActiveRecord::Base
  attr_accessible :content
  belongs_to :user
  
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: 1024}
  
  default_scope order: 'desires.updated_at DESC'

  def modified_after_last_xmas?
  	# desire modified after last Xmas
  	self.updated_at && self.updated_at > Date.new(Time.now.year - 1, 12, 25)
  end
end
