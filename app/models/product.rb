class Product < ActiveRecord::Base
  attr_accessible :name, :top_design, :description

  # association
  belongs_to :designer
  belongs_to :room
  belongs_to :category
  belongs_to :productor, :polymorphic =>  true
  has_many :services
end
