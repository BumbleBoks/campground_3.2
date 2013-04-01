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

require "spec_helper"

describe User do
  before { @user = User.new(login_id: "example", name: "The Example", email: "example@example.com",
      password: "1password", password_confirmation: "1password") }      
  subject { @user }
  
  it { should respond_to(:login_id) }
  it { should respond_to(:name) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:admin) }
  it { should respond_to(:authenticate) }
  
  it { should be_valid }
  it { should_not be_admin }
  
  describe "sets admin attribute to true" do
    before do
      @user.save
      @user.toggle!(:admin)
    end
    it { should be_admin}
  end
  
  describe "admin attribute" do
    it "should be inaccessible" do
      expect do
        User.new(admin: true)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)      
    end
  end
  
  describe "without login_id" do
    before { @user.login_id = ' ' }    
    it { should_not be_valid }
  end
  
  describe "without name" do
    before { @user.name = ' ' }
    it { should_not be_valid }
  end
  
  describe "without email" do
    before { @user.email = ' ' }
    it { should_not be_valid }
  end
  
  describe "without password" do
    before { @user.password = @user.password_confirmation = ' ' }
    it { should_not be_valid }
  end
  
  describe "without password confirmation" do
    before { @user.password_confirmation = nil }
    it { should_not be_valid }
  end
  
  describe "with duplicate login" do
    before do
      user_with_dup_login = @user.dup # creates a copy
      user_with_dup_login.email = 'somethingelse@example.com'
      user_with_dup_login.save
    end
    it { should_not be_valid }    
  end
  
  describe "with duplicate login in different case" do
    before do
      user_with_dup_login = @user.dup
      user_with_dup_login.login_id = @user.login_id.upcase
      user_with_dup_login.email = 'somethingelse@example.com'
      user_with_dup_login.save
    end
    it { should_not be_valid }
  end
  
  describe "with duplicate email" do
    before do
      user_with_dup_email = @user.dup # creates a copy
      user_with_dup_email.login_id = 'somethingelse'
      user_with_dup_email.save
    end
    it { should_not be_valid }    
  end
  
  describe "with duplicate email in different case" do
    before do
      user_with_dup_email = @user.dup
      user_with_dup_email.email = @user.email.upcase
      user_with_dup_email.login_id = 'somethingelse'
      user_with_dup_email.save
    end
    it { should_not be_valid }
  end
  
  describe "with valid login format" do
    logins = %w[xyz0y Zy987 987 abc]
    
    logins.each do |login|
      before { @user.login_id = login }
      it { should be_valid }
    end   
  end

  describe "with invalid login format" do
    logins = %w[x.y.yz0y Z@y987 #987 ab%%c $bfdm]
    
    logins.each do |login|
      before { @user.login_id = login }
      it { should_not be_valid }
    end   
  end

  describe "with valid email format" do
    addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn
      user2@foo.com]
    addresses.each do |address|
      before { @user.email = address }
      it { should be_valid }
    end
  end

  describe "with invalid email format" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo. 
        foo@bar_baz.com foo@bar+baz.com]
    addresses.each do |address|
      before { @user.email = address }
      it { should_not be_valid }
    end      
  end

  describe "with valid password format" do
    passwords = %w[abc123 $1a2b?3c 1#23%abc b@ca<123} bc#12a3 2!31*abc]
    
    passwords.each do |password|
      before { @user.password = @user.password_confirmation = password }
      it { should be_valid }
    end
  end
  
  describe "with invalid password format" do
    passwords = %w[abcdefg AbCdEfG 1234567]
    
    passwords.each do |password|
      before { @user.password = @user.password_confirmation = password }
      it { should_not be_valid }
    end
  end  

  describe "with mixed case login_id" do
    let (:mixed_case_login) { "FooBar" }
    
    it "should be saved as all lower case" do
      @user.login_id = mixed_case_login
      @user.save
      @user.reload.login_id.should == mixed_case_login.downcase
    end
  end
  
  describe "with mixed case email address" do
    let (:mixed_case_email) { "Foo@eXAMple.CoM" }
    
    it "should be saved as all lower case" do
      @user.email = mixed_case_email
      @user.save
      @user.reload.email.should == mixed_case_email.downcase
    end    
  end
  
  describe "with a very long name" do
    before { @user.name = 'z'*51 }
    it { should_not be_valid }
  end
  
  describe "with a very short password" do
    before { @user.password = @user.password_confirmation = 'y'*5 }    
    it { should_not be_valid }
  end
  
  describe "with a non-matching password confimration" do
    before { @user.password_confirmation = "1nomatch"}
    it { should_not be_valid }
  end
  
  describe "authentication" do
    before { @user.save }
    let (:found_user) { User.find_by_login_id(@user.login_id) } 

    describe "with valid password" do
      it { should == found_user.authenticate(@user.password) }
    end
    
    describe "with invalid password" do
      let (:user_with_invalid_password) { found_user.authenticate("invalid") }
      
      it { should_not == user_with_invalid_password }
      specify { user_with_invalid_password.should be_false } 
    end
  end
  
end
