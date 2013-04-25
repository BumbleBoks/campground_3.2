require "spec_helper"

describe UserMailer do  
  after(:all) { clear_all_databases } 

  describe "invite email" do
    let(:email) { "invite2example.com" }      
    before do
      @request = Site::UserRequest.new
      @request.email = email
      @request.token = 'abcdefgh'
      @request.request_type ='newuser'
      @request.save
    end
    
    it "adds email to deliveries array" do
      expect do
        UserMailer.invite_message(@request).deliver      
      end.to change(ActionMailer::Base.deliveries, :count).by(1)      
    end
    
    describe "shows correct address and subject" do
      before do
        @actual_email = UserMailer.invite_message(@request).deliver      
        @html_email_message = "<p>You're invited to join campground.<\/p>"
        @text_email_message = "Join campground by visiting"
      end
    
      subject {@actual_email}
      its (:to) { should eq ([email]) }
      its (:subject) { should eq("Campground Invitation") }
      its (:encoded) { should include(@html_email_message) }
      its (:encoded) { should include(@text_email_message) }                          
    end
  end

  describe "welcome email to new user" do  
    let(:user) { FactoryGirl.create(:user) }
    
    it "adds email to deliveries array" do
      expect do
        UserMailer.welcome_message(user).deliver      
      end.to change(ActionMailer::Base.deliveries, :count).by(1)      
    end
    
    describe "shows correct address and subject" do
      before do
        @actual_email = UserMailer.welcome_message(user).deliver      
        @html_email_message = "<p>Thank you for joining campground, #{user.name}.<\/p>"
        @text_email_message = "Thank you for joining campground, #{user.name}."
      end
    
      subject {@actual_email}
      its (:to) { should eq ([user.email]) }
      its (:subject) { should eq("Welcome to Campground") }
      its (:encoded) { should include(@html_email_message) }
      its (:encoded) { should include(@text_email_message) }                          
    end
  end

  describe "password reset email to user" do  
    let(:user) { FactoryGirl.create(:user) }
    
    before do
      @request = Site::UserRequest.new
      @request.email = user.email
      @request.token = 'abcdefgh'
      @request.request_type ='password'
      @request.save
    end
    
    it "adds email to deliveries array" do
      expect do
        UserMailer.reset_password_message(user, @request).deliver      
      end.to change(ActionMailer::Base.deliveries, :count).by(1)      
    end
    
    describe "shows correct address and subject" do
      before do
        @actual_email = UserMailer.reset_password_message(user, @request).deliver 
        @html_email_message = "Reset password"
        @text_email_message = "Reset password by visiting"
      end
    
      subject {@actual_email}
      its (:to) { should eq ([user.email]) }
      its (:subject) { should eq("Your Campground Account") }
      its (:encoded) { should include(@html_email_message) }
      its (:encoded) { should include(@text_email_message) }                          
    end
  end

end
