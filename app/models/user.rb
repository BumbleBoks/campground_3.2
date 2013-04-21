# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  login_id        :string(50)       not null
#  name            :string(50)       not null
#  email           :string(255)      not null
#  password_digest :string(255)      not null
#  admin           :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :login_id, :name, :email, :password, :password_confirmation, :current_password
  
  has_secure_password
  
  has_many :updates, 
           class_name: "Community::Update", 
           foreign_key: "author_id",
           dependent: :destroy
  
  has_many :favorite_activities, class_name: "Corner::FavoriteActivity", 
           foreign_key: "user_id", dependent: :destroy
  has_many :activities, class_name: "Common::Activity", through: :favorite_activities
  
  has_many :favorite_trails, class_name: "Corner::FavoriteTrail", 
           foreign_key: "user_id", dependent: :destroy
  has_many :trails, class_name: "Common::Trail", through: :favorite_trails
  
  accepts_nested_attributes_for :trails, allow_destroy: true, reject_if: :all_blank 
  accepts_nested_attributes_for :activities, allow_destroy: true, reject_if: :all_blank   

  VALID_LOGIN_REGEX = /^[A-Za-z\d_]+$/
  validates :login_id, presence: true,
            length: { minimum: 1, maximum: 50 },
            uniqueness: { case_sensitive: false },
            format: { with: VALID_LOGIN_REGEX }
  validates :name, presence: true,
            length: { minimum: 1, maximum: 50 }
  VALID_EMAIL_REGEX = /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  validates :email, presence: true,
            uniqueness: { case_sensitive: false },
            format: { with: VALID_EMAIL_REGEX }
  VALID_PASSWORD_REGEX = /.*[a-zA-z]+.*\d+.*|.*\d+.*[a-zA-z]+.*/
  validates :password, presence: true,
            length: { minimum: 6 },
            format: { with: VALID_PASSWORD_REGEX }
  validates :password_confirmation, presence: true
  
  before_save do
    login_id.downcase! 
    email.downcase!
  end
  
  # virtual attributes  
  def current_password=(password)
    self.current_password=password if password.present?
  end
  
  
  # class methods
  def self.partial_params
    [["current_password", "password", "password_confirmation"], ["login_id", "name", "email"]]    
  end
  
  def self.password_partial_params?(user_params)
    user_params.keys.eql?(partial_params[0])
  end
  
  # instance methods
  def update_partial_attributes(user_params)  
    unless self.class.partial_params.include?(user_params.keys)
      self.errors.add("parmeters", "cannot be updated!")
    end
    
    if self.class.password_partial_params?(user_params)
      if self.authenticate(user_params["current_password"]) 
        user_params.delete(:current_password)
      else
        self.errors.add("current_password", "is not correct. User authentication failed")
      end
    end

    unless self.errors.any?
      self.assign_partial_attributes(user_params)
    end

    !self.errors.any?
  end


  def assign_partial_attributes(user_params)
    if self.validate_partial_attributes(user_params)    
      user_params.keys.each do |key|
        self.update_attribute(key, user_params[key])        
      end
    end      
  end
  
  
  def validate_partial_attributes(user_params)
    self.update_attributes(user_params)
    original_errors = self.errors.dup
    self.populate_errors_for_params(original_errors, user_params) if self.errors.any?
    !self.errors.any?
  end  
    
  
  def populate_errors_for_params(add_errors, user_params)
    self.errors.clear

      add_errors.messages.keys.each do |key|          
        if user_params.has_key?(key)
          add_errors.messages[key].each do |message|
            self.errors.add(key, message)
          end # add error message 
        end #key in user_params        
    end    
  end # populate_errors
  
end
