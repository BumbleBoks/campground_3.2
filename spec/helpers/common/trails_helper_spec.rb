require "spec_helper"
include Common::TrailsHelper

describe "StaticPagesHelper" do
  before do
    @state_activities = state_activity()
  end
  
  subject { @state_activities }
  
  it { should_not be_empty }
  # it { should respond_to(:category_label) }
  
  # describe "all labels are generated" do
  #   before do
  #     state = Common::State.find_by_name("Arizona")
  #     activity = Common::Activity.find_by_name("Cycling")
  #     @new_element = StateActivity.new(state, activity, []).category_label
  #   end
  # 
  #   @new_element.should =~ "Arizona,Cycling"
  #   
  # end
  
end