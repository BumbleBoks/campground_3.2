require 'spec_helper'

describe "UserPages" do
  
  subject { page }
  
  describe "signup page" do
    before { visit join_path }
    
    it { has_page_title('Join Campground') }
    it { should have_selector('h2', text: 'Join') }
    it { should_not have_selector('button', text: 'Join') }
    it { should have_selector('button', text: 'Log in') }
    it { should_not have_selector('button', text: 'Profile') }
    it { should_not have_selector('button', text: 'Logout') }
  end
  
  describe "joining process" do
    before { visit join_path }
    let (:submit) { "Create my account" }
    
    describe "with not enough information" do
      it "should not create a user" do 
        expect { click_button submit }.not_to change(User, :count)
      end
      
      describe "after submitting empty form" do
        before { click_button submit }
        
        it { has_page_title('Join Campground') }
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
    end
    
    
  end
  
end