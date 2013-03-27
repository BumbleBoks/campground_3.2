# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  login_id        :string(255)
#  name            :string(255)
#  email           :string(255)
#  password_digest :string(255)
#  remember_token  :string(255)
#  admin           :boolean
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :login_id, :name, :email, :password, :password_confirmation
  has_secure_password
  
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
  validates :password,
            length: { minimum: 6 },
            format: { with: VALID_PASSWORD_REGEX }
  validates :password_confirmation, presence: true
  
  before_save do
    login_id.downcase! 
    email.downcase!
  end

end
