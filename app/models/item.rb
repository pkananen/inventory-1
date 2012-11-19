class Item < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, :use => :slugged
  attr_accessible :name, :value, :quantity, :category_id, :new_category_name, :image
  
  
   belongs_to :itemable, :polymorphic => true
   
   belongs_to :category
   scope :red, :conditions => { :id => '1' }
   accepts_nested_attributes_for :category
   attr_accessor :new_category_name
   before_save :create_category_from_name
   
   #mount_uploader :image, ImageUploader
   
   
  def create_category_from_name
  create_category(:name => new_category_name) unless new_category_name.blank?
end 
   
end




