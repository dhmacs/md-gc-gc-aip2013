class GroupInfo < ActiveRecord::Base
  attr_accessible :description, :title, :is_entry_page

  belongs_to :group
  has_many :images, :as => :image_ref
end
