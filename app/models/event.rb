class Event < ActiveRecord::Base
  attr_accessible :address, :city, :description, :name
end
