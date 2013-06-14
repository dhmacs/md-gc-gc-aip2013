class Product < ActiveRecord::Base
  attr_accessible :name, :top_design, :description

  # association
  belongs_to :designer
  belongs_to :room
  belongs_to :category
  belongs_to :manufacturer, :polymorphic =>  true
  has_and_belongs_to_many :services
  has_many :images, :as => :image_ref
end
