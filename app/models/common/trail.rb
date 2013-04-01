# == Schema Information
#
# Table name: common_trails
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  length      :decimal(, )
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Common::Trail < ActiveRecord::Base
  attr_accessible :description, :length, :name
  
  VALID_NAME_REGEX = /^[A-Za-z\d_]+( |\w)*$/
  validates :name,  presence: true
  validates :length,  numericality: true
end
