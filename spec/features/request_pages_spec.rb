require "spec_helper"

describe "Request pages" do
  let (:user) { FactoryGirl.create(:user) }
  subject { page }

  describe "request page for password change" do
    before do
      @request = Site::UserRequest.generate_new(user.email, "password")
      @request.save
    end

    describe "with invalid token" do
      before { visit edit_site_user_request_path(1234) }
      
      it { should have_page_title("Campground") }
      it { should have_selector('h2', text: "Welcome to Campground") } 
    end
    
    describe "with valid token" do      
      before do         
        visit edit_site_user_request_path(@request.token) 
       end

      it { should have_page_title("Campground") }
      it { should have_selector('h2', text: "Resetting Password") } 

      describe "resetting password with invalid values" do
        before do
          fill_in "New password", with: "1"
          fill_in "Confirm new password", with: ""
          click_button "Reset password"
        end

        it { should have_selector('h2', text: "Resetting Password") }
        it { should have_content("Password doesn\'t match confirmation") }      
        it { should have_content("Password is too short (minimum is 6 characters)") }      
        it { should have_content("Password confirmation can\'t be blank") }      
      end

      describe "resetting password with valid values" do
        before do
          fill_in "New password", with: "1password"
          fill_in "Confirm new password", with: "1password"
          click_button "Reset password"
        end

        it { should have_page_title("Campground - #{user.name}'s Campsite") }
        it { should have_selector('h2', text: "My campsite") }
        it { should have_content('Password was reset') }      
      end
    end # with valid token
  end # request page for password change 
  
end