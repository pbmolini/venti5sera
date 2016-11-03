class Category < ActiveRecord::Base
  attr_accessible :name, :icon
  has_many :users

  def to_s
    name
  end
end
