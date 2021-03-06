# == Schema Information
#
# Table name: corner_logs
#
#  id          :integer          not null, primary key
#  user_id     :integer          not null
#  title       :string(100)      not null
#  content     :text             not null
#  activity_id :integer
#  log_date    :date             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Corner::Log < ActiveRecord::Base
  attr_accessible :activity_id, :content, :log_date, :title
  
  belongs_to :user, class_name: "User", foreign_key: "user_id"
  has_many :log_tags, class_name: "Corner::LogTag", foreign_key: "associated_id",
    dependent: :destroy
  has_many :tags, class_name: "Site::Tag", through: :log_tags
  
  validates :user_id, presence: true
  validates :title, presence: true,
            length: { maximum: 100 }
  validates :content, presence: true,
            length: { maximum: 1000 }
  validates :log_date, presence: true
  
  before_validation :set_log_date
          
  protected        
  def set_log_date
    if log_date.nil?
      self.log_date = Date.current
    end    
  end        
end
