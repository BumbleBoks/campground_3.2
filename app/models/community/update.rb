# == Schema Information
#
# Table name: community_updates
#
#  id         :integer          not null, primary key
#  content    :text             not null
#  author_id  :integer          not null
#  trail_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Community::Update < ActiveRecord::Base
  attr_accessible :content, :trail_id
  
  belongs_to :author, 
             class_name: "User"
  
  belongs_to :trail, 
             class_name: "Common::Trail"
  
  validates :content, presence: true,
            length: { maximum: 500 }
  validates :author_id, presence: true
  validates :trail_id, presence: true
end
