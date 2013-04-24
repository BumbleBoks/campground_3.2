# == Schema Information
#
# Table name: site_tags
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Site::Tag < ActiveRecord::Base
  attr_accessible :name
  
  has_many :tag_associations, class_name: "Site::TagAssociations", foreign_key: "tag_id",
      dependent: :destroy
  
  validates :name, presence: true,                
            format: { with: /^[A-Za-z]+$/ },
            length: { maximum: 20 },
            uniqueness: { case_sensitive: false }
  
  before_save { name.downcase! }
end
