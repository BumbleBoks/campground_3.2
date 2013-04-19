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
    user_request = Site::UserRequest.new
    user_request.email = email
    user_request.token = Digest::SHA2.hexdigest(rand.to_s)
    user_request.request_type = request_type
    user_request
  end
end
