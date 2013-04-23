class Site::Tag < ActiveRecord::Base
  attr_accessible :name
  
  has_many :tag_associations, class_name: "Site::TagAssociation", foreign_key: "tag_id",
      dependent: :destroy
  
  validates :name, presence: true,                
            format: { with: /^[a-zA-Z]+$/ },
            length: { maximum: 20 },
            uniqueness: { case_sensitive: false }
  
  before_save { name.downcase! }
end
