class Service < ActiveRecord::Base
  attr_accessible :description, :name, :additional_info

  has_and_belongs_to_many :products
end
