class Group < ActiveRecord::Base
  attr_accessible :name

  has_many :products, :as => :productor
  has_many :group_infos
end
