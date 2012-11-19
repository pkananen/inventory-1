class Compartment < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, :use => :slugged

    
  belongs_to :level
  has_many :items, :as => :itemable
  attr_accessible :description, :name
end
