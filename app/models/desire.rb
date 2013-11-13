class Desire < ActiveRecord::Base
  attr_accessible :content
  belongs_to :user
  
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: 1024}
  
  default_scope order: 'desires.updated_at DESC'

  def current_desire?
  	self.updated_at.year == Time.now.year  	
  end
end
