require "spec_helper"

describe UserMailer do  
  after(:all) { clear_all_databases } 

  describe "test email is sent to the user" do  
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
end
