class Partner < ActiveRecord::Base
  attr_accessible :name

  has_many :products, :as => :productor
end
