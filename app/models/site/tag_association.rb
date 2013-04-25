# == Schema Information
#
# Table name: site_tag_associations
#
#  id            :integer          not null, primary key
#  tag_id        :integer          not null
#  associated_id :integer          not null
#  type          :string(255)      not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Site::TagAssociation < ActiveRecord::Base
  attr_accessible :associated_id, :tag_id, :type
  
  belongs_to :tag, class_name: "Site::Tag", foreign_key: "tag_id",
    inverse_of: :tag_associations
  
  validates :tag_id,  presence: true
  validates :associated_id,  presence: true
  validates :type,  presence: true
end
