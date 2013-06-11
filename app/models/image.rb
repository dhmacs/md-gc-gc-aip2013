class Image < ActiveRecord::Base
  attr_accessible :extension, :name

  # association
  belongs_to :image_ref, :polymorphic => true
end
