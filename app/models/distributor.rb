class Distributor < ActiveRecord::Base
  attr_accessible :address, :cap, :city, :fax, :mail, :name, :phone_number
end
