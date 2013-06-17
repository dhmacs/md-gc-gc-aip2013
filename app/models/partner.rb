class Partner < ActiveRecord::Base
  attr_accessible :name, :description, :website

  #association
  has_one :image, :as => :image_ref
  belongs_to :group
  has_many :products, :as => :manufacturer
  has_one :image, :as => :image_ref
end
