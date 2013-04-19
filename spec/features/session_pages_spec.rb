require 'spec_helper'

describe "SessionPages" do
  
  subject { page }
  
  describe "log in" do
    
    before { visit login_path }
    
    it { should have_page_title("Campground Log In") }
    it { should have_selector('h2', text: "Enter campground") }
    
    it { should_not have_link('Log in') }
    it { should have_button('Forgot password?') }
    
    describe "with incorrect information" do
      before { click_button "Log in" }
      
      # it { should have error message }
      it { should have_selector('h2', text: "Enter campground") }
    end
    
    # TODO - needs config.use_transactional_fixtures = false
    # describe "on clicking Forgot password", js: true do
    #   
    #   it "should send password_reset_email" do
    #     user = FactoryGirl.create(:user)
    #     visit login_path
    #     fill_in "Login ID", with: user.login_id
    # 
    #     click_button "Forgot password?"
    #     password_change_email = ActionMailer::Base.deliveries.last 
    # 
    #     html_email_message = "Reset password"
    #     text_email_message = "Reset password by visiting"
    # 
    #     expect(password_change_email.to).to eq([user.email])
    #     expect(password_change_email.subject).to eq("Your Campground Account")
    #     expect(password_change_email.encoded).to include(html_email_message)
    #     expect(password_change_email.encoded).to include(text_email_message)    
    #   end

      
      
      # let(:password_change_email) { ActionMailer::Base.deliveries.last }
      # let(:user) { FactoryGirl.create(:user) }
      # 
      # before do
      #   # @user = FactoryGirl.create(:user)
      #   visit login_path
      #   fill_in "Login ID", with: user.login_id.upcase
      # end
      # 
      # it "should create a new user request" do
      #   expect { click_button "Forgot password?" }.to change(Site::UserRequest, :count).by(1)        
      # end
      # 
      # describe "should send an email" do
      #   before { click_button "Forgot password?" }
      #   
      #   it "for resetting password" do
      #     html_email_message = "Reset password"
      #     text_email_message = "Reset password by visiting"
      # 
      #     expect(password_change_email.to).to eq([user.email])
      #     expect(password_change_email.subject).to eq("Your Campground Account")
      #     expect(password_change_email.encoded).to include(html_email_message)
      #     expect(password_change_email.encoded).to include(text_email_message)        
      #   end            
      # end
      
    #end
    
    describe "with correct information" do
      let (:user) { FactoryGirl.create(:user) }
      before { log_in user }   
      
      it { should have_page_title("Campground - #{user.name}'s Campsite") }
      it { should have_link('Log out', href: logout_path) }
      it { should have_link('Profile', href: user_path(user)) }
      it { should_not have_link('Join', href: join_path) }
      it { should_not have_link('Log in', href: login_path) }
      
      describe "and then log out" do
        before { click_link 'Log out' }
        
        it { should have_page_title("Campground") }
        it { should have_link('Log in', href: login_path) }
        it { should have_link('Join', href: join_path) }
        it { should_not have_link('Log out') }
        it { should_not have_link('Profile') }
        
      end
    end
  end
end
