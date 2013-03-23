require 'spec_helper'

describe "Static pages" do
  
  subject { page }
  
  # test for layout - should be run for all pages  
  shared_examples_for "all static pages" do
    it { should have_css("#user_individual") }
    it { should have_css("#user_community") }
    it { should have_css("#user_dynamic") }
  end
  
  describe "Home page" do
    before { visit root_path }
    
    it_should_behave_like "all static pages"

    it { has_page_title("Campground") }
    it { should have_selector('h2', text: "Welcome to Campground") }
    
    it { should have_link("About", href: about_path) }
    it { should have_link("Contact", href: contact_path) }
  end
  
  describe "About page" do
    before { visit about_path }
    
    it_should_behave_like "all static pages"
    
    it { has_page_title("About Campground") }
    it { should have_selector('h2', text: "About") }
    
  end
  
  describe "Contact page" do
    before { visit contact_path }
    
    it_should_behave_like "all static pages"

    it { has_page_title("Contact Campground") }
    it { should have_selector('h2', text: "Contact Info") }
  end
  
end