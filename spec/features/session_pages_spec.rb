require 'spec_helper'

describe "SessionPages" do
  
  subject { page }
  
  describe "log in" do
    
    before { visit login_path }
    
    it { should have_page_title("Campground Log In") }
    it { should have_selector('h2', text: "Enter campground") }
    
    it { should_not have_link('Log in') }
    
    describe "with incorrect information" do
      before { click_button "Log in" }
      
      # it { should have error message }
      it { should have_selector('h2', text: "Enter campground") }
    end
    
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
