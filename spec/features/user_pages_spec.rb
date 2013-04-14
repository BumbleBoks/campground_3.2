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
  end # joining process
  
  describe "show page" do
    let (:user) { FactoryGirl.create(:user) }
    let (:other_user) { FactoryGirl.create(:user) }
    let (:trail) { create_trail }
    let(:update) { user.updates.create(trail_id: trail.id, content: "Trail closed") }

    before { visit user_path (user) }
    
    it_should_behave_like "home page when not logged in"
    
    describe "after logging in" do
      before do
        user.favorite_activities.create(activity_id: Common::Activity.find_by_name("Cycling").id)
        update.save
        log_in user
        visit user_path(user)
      end      
      it { should have_page_title("Campground - #{user.name}") }
      it { should have_selector('h2', text: "About #{user.name}") }
      it { should have_link('Change profile', edit_user_path(user)) }
      
      it { should have_content("#{user.name}") }
      it { should have_content("#{user.email}") }
      it { should have_content("Cycling") }
      it { should have_content(update.content) }      
    end
    
    describe "visiting other user's profile" do
      before do
        log_in user
        visit user_path(other_user) 
      end
      
      it { should have_page_title("Campground - #{other_user.name}") }
      it { should have_selector('h2', text: "About #{other_user.name}") }
      it { should_not have_link('Change Profile') }
    end      
  end # show page
  
  describe "edit page" do
    let (:user) { FactoryGirl.create(:user) }
    let (:other_user) { FactoryGirl.create(:user) }

    describe "without logging in" do
      before { visit edit_user_path(user) }
      it_should_behave_like "home page when not logged in"
    end
    
    describe "after logging in" do
      before do
        log_in user
        visit edit_user_path(user)
      end 
      
      it { should have_page_title("Campground - Profile") }
      it { should have_selector('h2', text: "Changing Profile") }
      it { should have_link('Change favorites', favorites_new_path) }
        
      describe "on submitting invalid values" do
        before do
          fill_in "Login ID", with: other_user.login_id
          fill_in "Name", with: ""
          fill_in "Email", with: "examplefoo@example"
          click_button "Save Profile"
        end

        it { should have_selector('h2', text: "Changing Profile") }
        it { should have_content('error') }
        it { should have_content('Login has already been taken') }
        it { should have_content('Name can\'t be blank') }
        it { should have_content('Email is invalid') }
      end # invalid values
      
      describe "after submitting valid values" do
        before do
          fill_in "Login ID", with: "examplefoo"
          fill_in "Name", with: "Example Foo"
          fill_in "Email", with: "examplefoo@example.com"
          # fill_in "Password", with: "1password"
          # fill_in "Confirm password", with: "1password"
          click_button "Save Profile"
        end

        it { should have_selector('h2', text: "About Example Foo") }
        it { should have_content("examplefoo@example.com") }
      end # valid values
      
      describe "on clicking password change button" do
        before do
          click_link "Change password"
        end
        
        it { should have_selector('h2', text: "Changing Password") }
        it { should have_selector('label', text: "New password") }
        it { should have_selector('label', text: "Confirm new password") }
        
        describe "changing password with incorrect authentication" do
          before do
            fill_in "Current password", with: ""
            fill_in "New password", with: "1password"
            fill_in "Confirm new password", with: "1password"
            click_button "Save password"
          end
          
          it { should have_content("Current password is not correct. User authentication failed") }
          
        end

        describe "changing password with correct authentication and invalid passwords" do
          before do
            fill_in "Current password", with: user.password
            fill_in "New password", with: ""
            fill_in "Confirm new password", with: "1password"
            click_button "Save password"
          end
          
          it { should have_content("Password doesn\'t match confirmation") };
          it { should have_content("Password can\'t be blank") };
          it { should have_content("Password is too short (minimum is 6 characters)") };
          it { should have_content("Password is invalid") };
          
        end

        describe "changing password with correct authentication and valid passwords" do
          before do
            fill_in "Current password", with: user.password
            fill_in "New password", with: "1password"
            fill_in "Confirm new password", with: "1password"
            click_button "Save password"
          end
          
          it { should have_selector('h2', text: "Changing Profile") }
          it { should have_selector('label', text: 'Login ID') }
          
        end

      end # valid values
      
    end # after logging in
         
    describe "editing other user's profile" do
      before do
        log_in user
        visit edit_user_path(other_user)
      end
      
      it { should have_page_title("Campground - #{user.name}'s Campsite") }
      it { should have_selector('h2', text: "My campsite") } 
    end
    
  end
end
