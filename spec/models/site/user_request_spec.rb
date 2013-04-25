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

require 'spec_helper'

describe Site::UserRequest do
  before do
    @request = Site::UserRequest.new() 
    @request.email = "foo@example.com" 
    @request.token = "cc765535a33e25d0012322fa697ddb298"
    @request.request_type = "password" 
  end

  subject { @request }

  it { should respond_to(:email) }  
  it { should respond_to(:token) }
  it { should respond_to(:request_type) }
  it { should be_valid }

  it { should be_invalid_with_attribute_value(:email, "") }
  it { should be_invalid_with_attribute_value(:token, "") }
  it { should be_invalid_with_attribute_value(:request_type, "") }

  describe "with valid email format" do
    addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn
      user2@foo.com]
    addresses.each do |address|
      before { @request.email = address }
      it { should be_valid }
    end
  end

  describe "with invalid email format" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo. 
        foo@bar_baz.com foo@bar+baz.com]
    addresses.each do |address|
      it { should be_invalid_with_attribute_value(:email, address) }
    end      
  end

  describe "accessible attributes" do
    it "should not allow access to token" do
      expect do
        Site::UserRequest.new(token:"cc765535a33e25d0012322fa697ddb298")
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end

    it "should not allow access to email" do
      expect do
        Site::UserRequest.new(email: "foo@example.com")
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end

    it "should not allow access to type" do
      expect do
        Site::UserRequest.new(request_type: "password")
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end

  end
  
  describe "generate_new function should generate new token" do
    before { @new_request = Site::UserRequest.generate_new("foo@example.com", "password") }
    
    it "should be valid" do
      @new_request.should be_valid
    end
    
  end
end
