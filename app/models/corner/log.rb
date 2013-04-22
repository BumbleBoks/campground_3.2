class Corner::Log < ActiveRecord::Base
  attr_accessible :activity_id, :content, :log_date, :title
  
  belongs_to :user, class_name: "User", foreign_key: "user_id"
  
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
      self.log_date = Time.zone.today
    end    
  end        
end
