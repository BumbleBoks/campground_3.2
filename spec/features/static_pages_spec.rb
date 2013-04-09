require 'spec_helper'

describe "Static pages" do  
  let (:user) { FactoryGirl.create(:user) }
  let (:state) { Common::State.find_by_name("Colorado") }
  let (:activity) { Common::Activity.find_by_name("Cycling") }  
  # let (:trail_one) { FactoryGirl.create(:trail, name: "Trail One", state: state, activity_ids: activity.id) }
  # let (:trail_two) { FactoryGirl.create(:trail, name: "Trail Two", state: state, activity_ids: activity.id) }
  # let (:update1) { user.updates.create!(trail_id: trail_one.id, content: "Icy patches on trail") }
  # let (:update2) { user.updates.create!(trail_id: trail_two.id, content: "Flowers blooming") }
  
  subject { page }
    
  describe "Home page" do
    before { visit root_path }
    
    it_should_behave_like "all pages without logging in"

    it { should have_page_title("Campground") }
    it { should have_selector('h2', text: "Welcome to Campground") }
    
    it { should have_select('state_id') }
    it { should have_select('activity_id') } 
    it { should have_select('trail_id') }
    
    # Common::State.all.each do |state|
    #   Common::Activity.all.each do |activity|
    #     it { should have_selector('optgroup', label: "#{state.name},#{activity.name}") }
    #   end
    # end
    
    describe "trails updates" do      
      describe "trails are shown in correct category" do
        before do
          @trail_one = FactoryGirl.create(:trail, name: "Trail One", state: state, activity_ids: activity.id) 
          @trail_two = FactoryGirl.create(:trail, name: "Trail Two", state: state, activity_ids: activity.id) 
          @update1 = user.updates.create!(trail_id: @trail_one.id, content: "Icy patches on trail") 
          @update2 = user.updates.create!(trail_id: @trail_two.id, content: "Flowers blooming") 
          @label_name = "#{state.name},#{activity.name}"
          visit root_path
        end
        it { should have_optgroup_with_label_and_text(@label_name, @trail_one.name) }
        it { should have_optgroup_with_label_and_text(@label_name, @trail_two.name) }
    
        it { should_not have_content(@update1.content) }
        it { should_not have_content(@update2.content) }
      end

      describe "check for updates" do
        before do
          @trail_one = FactoryGirl.create(:trail, name: "Trail One", state: state, activity_ids: activity.id) 
          @trail_two = FactoryGirl.create(:trail, name: "Trail Two", state: state, activity_ids: activity.id) 
          @update1 = user.updates.create!(trail_id: @trail_one.id, content: "Icy patches on trail") 
          @update2 = user.updates.create!(trail_id: @trail_two.id, content: "Flowers blooming") 

          visit root_path
          # select state.name
          # select activity.name
          click_link "Get updates"
          # select state.name
          # select activity.name
          select @trail_one.name
          click_link "Get updates"
        end
        
        # # TODO try with phantomJS
        # describe "should have heading", js: true do
        #   it { should have_content("Updates for #{@trail_one.name}") }
        # end
        # 
        # describe "should have update for trail one" do
        #   it { should have_content(@update1.content) } 
        # end

        describe "should not have update for trail two" do
          it { should_not have_content(@update2.content) }
        end  
      end
    end
    
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