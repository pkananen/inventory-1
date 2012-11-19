class Level < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, :use => :slugged
  belongs_to :container
  has_many :compartments, :dependent => :destroy
  attr_accessible :description, :image_url, :name
  has_many :items, :as => :itemable
  
  
    scope :categz, proc {|level| where(:level => level) }

end
