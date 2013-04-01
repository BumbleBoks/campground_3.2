require 'spec_helper'

describe "Static pages" do  
  let (:user) { FactoryGirl.create(:user) }
  
  subject { page }
    
  describe "Home page" do
    before { visit root_path }
    
    it_should_behave_like "all pages without logging in"

    it { should have_page_title("Campground") }
    it { should have_selector('h2', text: "Welcome to Campground") } 
    
    describe "for logged in user" do
      before { log_in user }
      
      it_should_behave_like "all pages for logged in user"      
      it { should have_link("Profile", user_path(user)) }
      it { should have_page_title("Campground - #{user.name}'s Campsite") }
      it { should have_selector('h2', text: "My campsite") } 
    end    
  end
  
  describe "About page" do
    before { visit about_path }
    
    it_should_behave_like "all pages without logging in"
    
    it { should have_page_title("About Campground") }
    it { should have_selector('h2', text: "About") }
    
    describe "for logged in user" do
      before do
        log_in user 
        visit about_path
      end
      
      it_should_behave_like "all pages for logged in user"      
      it { should have_link("Profile", user_path(user)) }
      it { should have_page_title("About Campground") }
      it { should have_selector('h2', text: "About") } 
    end
  end
  
  describe "Contact page" do
    before { visit contact_path }
    
    it_should_behave_like "all pages without logging in"

    it { should have_page_title("Contact Campground") }
    it { should have_selector('h2', text: "Contact Info") }

    describe "for logged in user" do
      before do
        log_in user 
        visit contact_path
      end
      
      it_should_behave_like "all pages for logged in user" 
      
      it { should have_link("Profile", user_path(user)) }
      it { should have_page_title("Contact Campground") }
      it { should have_selector('h2', text: "Contact Info") } 
    end
  end
  
end