class Group < ActiveRecord::Base
  attr_accessible :name

  # association
  has_many :partners
  has_many :products, :as => :manufacturer
end
