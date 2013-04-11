# == Schema Information
#
# Table name: common_activities
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Common::Activity < ActiveRecord::Base
  attr_accessible :name
  
  has_many :activity_associations, class_name: "Common::ActivityAssociation", 
           foreign_key: "activity_id", dependent: :destroy
  has_many :trails, class_name: "Common::Trail", through: :activity_associations
  
  has_many :favorite_activities, class_name: "Corner::FavoriteActivity", 
           foreign_key: "activity_id", dependent: :destroy
  has_many :users, class_name: "User", through: :favorite_activities
  
  VALID_NAME_REGEX = /^[A-Za-z\d_]+( |\w)*$/
  validates :name,  presence: true,
            uniqueness: { case_sensitivity: false },
            format: { with: VALID_NAME_REGEX }
end
