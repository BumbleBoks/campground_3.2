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
  attr_accessible :login_id, :name, :email, :password, :password_confirmation
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
  
  VALID_LOGIN_REGEX = /^[A-Za-z\d_]+$/
  validates :login_id, presence: true,
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

  def update_partial_attributes(user_params)    
    self.validate_partial_attributes(user_params)    
    unless self.errors.any?
      user_params.keys.each do |key|
        self.update_attribute(key, user_params[key])        
      end
    end
    
    !self.errors.any?
  end

  private
  def validate_partial_attributes(user_params)
    self.update_attributes(user_params)
    original_errors = self.errors.dup
    self.populate_errors(original_errors) if self.errors.any?
  end  
    
  
  def populate_errors(add_errors)
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
