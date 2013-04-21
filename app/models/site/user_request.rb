# == Schema Information
#
# Table name: site_user_requests
#
#  id           :integer          not null, primary key
#  email        :string(255)      not null
#  token        :string(255)      not null
#  request_type :string(255)      not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Site::UserRequest < ActiveRecord::Base

  validates :email,  presence: true
  validates :token,  presence: true
  validates :request_type,  presence: true
  
  # class methods
  def self.generate_new(email, request_type)
    user_request = new
    user_request.email = email
    user_request.token = generate_unique_token
    user_request.request_type = request_type
    user_request
  end
  
  private
  
  def self.generate_unique_token
    unique_token = false
    while !unique_token
      token = Digest::SHA2.hexdigest(rand.to_s)
      unique_token = true if Site::UserRequest.find_by_token(token).nil?            
    end    
    token
  end
  
end
