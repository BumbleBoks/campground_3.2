require "spec_helper"

describe "Log pages" do
  after(:all) { clear_all_databases }
  let (:user) { FactoryGirl.create(:user) }  
  subject { page }
  
  describe "creating a new log" do
    let (:submit) { "Create a new log" }
    
    describe "without logging in" do
      before { visit new_corner_log_path }
      it_should_behave_like "home page when not logged in"
    end
    
    describe "as a regular user" do
      before do
        log_in user
        visit new_corner_log_path
      end
      it { should have_page_title("Campground - #{user.name}'s Diary") }
      it { should have_selector('h2', text: "New Log") } 
    
    
      describe "with insufficient information" do
        it "should not create a new log" do
          expect { click_button submit }.not_to change(Corner::Log, :count)
        end
      end

      describe "after submitting empty form" do
        before { click_button submit }

        it { should have_page_title("Campground - #{user.name}'s Diary") }
        it { should have_content('error') }
        it { should have_content('Title can\'t be blank') }
        it { should have_content('Content can\'t be blank') }
      end
    
      describe "with sufficient valid information" do
        before do
          fill_in "Title", with: "New Log"
          fill_in "Content", with: "A great hike!"
        end

        it "should create a log" do
          expect { click_button submit }.to change(Corner::Log, :count).by(1)
        end   
      
        describe "should create a new log and show the new log" do
          before { click_button submit }

          it { should have_page_title("Campground - #{user.name}'s Diary") }
          it { should have_content(Date.current().to_formatted_s(:calendar_date)) }
          it { should have_content("New Log") }
          it { should have_content("A great hike!") }
        end 
      end # valid submission              
    end # authorized user
  end # new trail page
end
    
