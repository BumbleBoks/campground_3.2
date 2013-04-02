# == Schema Information
#
# Table name: common_trails
#
#  id          :integer          not null, primary key
#  name        :string(75)       not null
#  length      :decimal(5, 2)
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  state_id    :integer
#

class Common::Trail < ActiveRecord::Base
  # accepts_nested_attributes_for :activity_associations
  
  attr_accessible :description, :length, :name, :state_id
  
  belongs_to :state, 
             class_name: "Common::State", 
             foreign_key: "trail_id"
             
  has_many :activity_associations, class_name: "Common::ActivityAssociation", 
           foreign_key: "trail_id", dependent: :destroy
  has_many :activities, class_name: "Common::Activity", through: :activity_associations

  VALID_NAME_REGEX = /^[A-Za-z\d_]+( |\w)*$/
  validates :name, presence: true,
            uniqueness: { scope: :state_id }
  validates :length,  numericality: true
  validates :state_id, presence: true
end
