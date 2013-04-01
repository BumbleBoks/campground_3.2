# == Schema Information
#
# Table name: common_activities
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Common::Activity < ActiveRecord::Base
  attr_accessible :name
  
  VALID_NAME_REGEX = /^[A-Za-z\d_]+( |\w)*$/
  validates :name,  presence: true,
            uniqueness: { case_sensitivity: false },
            format: { with: VALID_NAME_REGEX }
end
