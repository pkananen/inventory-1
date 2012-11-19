class Category < ActiveRecord::Base
  attr_accessible :name
  
  has_many :items 
  
  belongs_to :user
end
