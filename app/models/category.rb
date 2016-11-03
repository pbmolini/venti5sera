class Category < ActiveRecord::Base
  attr_accessible :name
  has_many :users

  def to_s
    name
  end
end
