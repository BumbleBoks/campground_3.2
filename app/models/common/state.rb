# == Schema Information
#
# Table name: common_states
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Common::State < ActiveRecord::Base
  attr_accessible :name
  
  VALID_NAME_REGEX = /^[A-Za-z]+( |.|\w)*$/
  validates :name,  presence: true,
            uniqueness: { case_sensitivity: false }
  
end
