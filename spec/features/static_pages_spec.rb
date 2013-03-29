require 'spec_helper'

describe "Static pages" do  
  let (:user) { FactoryGirl.create(:user) }
  
  subject { page }
  
  # test for layout - should be run for all pages  
  shared_examples_for "all static pages" do
    it { should have_css("#user_individual") }
    it { should have_css("#user_community") }
    it { should have_css("#user_dynamic") }
    it { should have_link("About", href: about_path) }
    it { should have_link("Contact", href: contact_path) }    
    it { should have_link("Join", href: join_path) }
    it { should have_link("Log in", href: login_path) }
    it { should_not have_link("Profile") }
    it { should_not have_link("Log out") }
  end

  # test for layout with user logged in - should be run for all pages  
  shared_examples_for "all static pages for logged in user" do
    it { should have_css("#user_individual") }
    it { should have_css("#user_community") }
    it { should have_css("#user_dynamic") }
    it { should have_link("About", href: about_path) }
    it { should have_link("Contact", href: contact_path) }    
    it { should_not have_link("Join") }
    it { should_not have_link("Log in") }
    it { should have_link("Log out", logout_path) }
  end
  
  describe "Home page" do
    before { visit root_path }
    
    it_should_behave_like "all static pages"

    it { has_page_title("Campground") }
    it { should have_selector('h2', text: "Welcome to Campground") } 
    
    describe "for logged in user" do
      before { log_in user }
      
      it_should_behave_like "all static pages for logged in user"      
      it { should have_link("Profile", user_path(user)) }
      it { has_page_title("#{user.name}'s Campground") }
      it { should have_selector('h2', text: "Welcome to Campground") } 
    end    
  end
  
  describe "About page" do
    before { visit about_path }
    
    it_should_behave_like "all static pages"
    
    it { has_page_title("About Campground") }
    it { should have_selector('h2', text: "About") }
    
    describe "for logged in user" do
      before do
        log_in user 
        visit about_path
      end
      
      it_should_behave_like "all static pages for logged in user"      
      it { should have_link("Profile", user_path(user)) }
      it { has_page_title("About Campground") }
      it { should have_selector('h2', text: "About") } 
    end
  end
  
  describe "Contact page" do
    before { visit contact_path }
    
    it_should_behave_like "all static pages"

    it { has_page_title("Contact Campground") }
    it { should have_selector('h2', text: "Contact Info") }

    describe "for logged in user" do
      before do
        log_in user 
        visit contact_path
      end
      
      it_should_behave_like "all static pages for logged in user"      
      it { should have_link("Profile", user_path(user)) }
      it { has_page_title("Contact Campground") }
      it { should have_selector('h2', text: "Contact Info") } 
    end
  end
  
end