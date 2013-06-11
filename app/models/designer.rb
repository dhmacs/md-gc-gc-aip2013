class Designer < ActiveRecord::Base
  attr_accessible :biography, :first_name, :last_name

  # associations
  has_many :products
  has_one :image, :as => :image_ref

  # handy methods
  def full_name
    "#{first_name} #{last_name}"
  end

end
