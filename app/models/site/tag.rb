class Site::Tag < ActiveRecord::Base
  attr_accessible :name
  
  has_many :tag_associations, class_name: "Site::TagAssociations", foreign_key: "tag_id",
      dependent: :destroy
  
  validates :name, presence: true,                
            format: { with: /^[\w]+$/ },
            length: { maximum: 20 },
            uniqueness: { case_sensitive: false }
  
  before_save { name.downcase! }
end
