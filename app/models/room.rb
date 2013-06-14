class Room < ActiveRecord::Base
  attr_accessible :name

  #association
  has_many :products
  has_and_belongs_to_many :partners
end
