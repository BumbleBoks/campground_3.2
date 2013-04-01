require 'spec_helper'

describe "UserPages" do
  
  subject { page }
  
  describe "join page" do
    before { visit join_path }
    
    it { should have_page_title('Join Campground') }
    it { should have_selector('h2', text: 'Join campground') }
    it { should_not have_selector('button', text: 'Join') }
    it { should_not have_link('Profile') }
    it { should_not have_link('Log out') }
    it { should_not have_link('Join', href: join_path) }
    it { should have_link('Log in', href: login_path) }
  end
  
  describe "joining process" do
    before { visit join_path }    
    
    let (:submit) { "Create account" }
    
    describe "with not enough information" do
      it "should not create a user" do 
        expect { click_button submit }.not_to change(User, :count)
      end
      
      describe "after submitting empty form" do
        before { click_button submit }
        
        it { should have_page_title('Join Campground') }
        it { should have_content('error') }
        it { should have_content('Login can\'t be blank') }
        it { should have_content('Login is invalid') }
        it { should have_content('Name can\'t be blank') }
        it { should have_content('Email can\'t be blank') }
        it { should have_content('Email is invalid') }
        it { should have_content('Password can\'t be blank') }
        it { should have_content('Password is invalid') }
        it { should have_content('Password confirmation can\'t be blank') }
        it { should have_content('Password is too short (minimum is 6 characters)') }
      end            
    end
    
    describe "with enough information" do
      before do
        fill_in "Login ID", with: "examplefoo"
        fill_in "Name", with: "Example Foo"
        fill_in "Email", with: "examplefoo@example.com"
        fill_in "Password", with: "1foobar"
        fill_in "Confirm password", with: "1foobar"
      end

      it "should create a new user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
      
      describe "and login to home page" do
        before { click_button submit }
        let (:user) { User.find_by_login_id("examplefoo") }
        
        it { should have_link("Log out", logout_path) }
        it { should have_link("Profile", user_path(user)) }
        it { should_not have_link("Join") }
        it { should_not have_link("Log in") }
      end
      
    end
    
    
  end
  
end
