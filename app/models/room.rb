class Room < ActiveRecord::Base
  attr_accessible :name

  has_many :products
  has_one :image, :as => :image_ref
end
