class Container < ActiveRecord::Base
  
  extend FriendlyId
  friendly_id :name, :use => :slugged
  validates :name, :presence => {:message => 'cannot be blank, please try again'}
  attr_accessible :description, :image_url, :name, :user_id
  
  belongs_to :user
  has_many :levels, :dependent => :destroy
  has_many :items, :as => :itemable
  # this means rails understands @container.compartments (if needed)
  has_many :compartments, :through => :levels, :dependent => :destroy
end
