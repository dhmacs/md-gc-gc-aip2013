class Product < ActiveRecord::Base
  attr_accessible :name

  #association
  belongs_to :designer

end
