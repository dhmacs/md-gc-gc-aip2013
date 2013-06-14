class About < ActiveRecord::Base
  attr_accessible :description, :title

  has_many :images, :as => :image_ref
end
