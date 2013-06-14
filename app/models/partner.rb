class Partner < ActiveRecord::Base
  attr_accessible :name

  #association
  belongs_to :group
  has_many :products, :as => :manufacturer
end
