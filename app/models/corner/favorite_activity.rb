class Corner::FavoriteActivity < ActiveRecord::Base
  attr_accessible :activity_id
  
  belongs_to :user, class_name: "User", foreign_key: "user_id"
  belongs_to :activity, class_name: "Common::Activity", :foreign_key => "activity_id"
  
  validates :activity_id, presence: true
  validates :user_id, presence: true
end
