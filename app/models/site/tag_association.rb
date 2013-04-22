class Site::TagAssociation < ActiveRecord::Base
  attr_accessible :associated_id, :tag_id, :type
  
  belongs_to :tag, class_name: "Site::Tag", foreign_key: "tag_id",
    inverse_of: :tag_associations
  
  validates :tag_id,  presence: true
  validates :associated_id,  presence: true
  validates :type,  presence: true
end
