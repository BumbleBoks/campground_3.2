# == Schema Information
#
# Table name: common_activities
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Common::Activity do
  before { @activity = Common::Activity.new(name: "Footivity") }
  subject { @activity }
  
  it { should respond_to(:name) }
  it { should respond_to(:activity_associations) }
  it { should respond_to(:trails) }
  it { should respond_to(:favorite_activities) }
  it { should respond_to(:users) }
  it { should be_valid }
  
  describe "without name" do
    before { @activity.name = '' }
    it { should_not be_valid }
  end
  
  describe "with a duplicate name" do
    before do
      activity_with_dup_name = @activity.dup
      activity_with_dup_name.save
    end
    
    it { should_not be_valid }
  end
  
  describe "with invalid name format" do
    names = %w[a<43 h.890]    
    names.each do |name|
      before { @activity.name = name }
      it { should_not be_valid }
    end
  end
  
  describe "with valid name format" do
    before { @activity.name = "1abc def" }
    it { should be_valid }
  end
  
  describe "activity associations" do
    let!(:trail) { create_trail }
    before do
      @activity.save
      trail.activity_associations.create!(activity_id: @activity.id) 
    end
    
    it "should destroy activity_associations for the activity" do
      activity_associations = @activity.activity_associations.dup
      @activity.destroy
      activity_associations.should_not be_empty
      activity_associations.each do |activity_association|
        Common::ActivityAssociation.find_by_id(activity_association.id).should be_nil
      end
    end
  end
  
  describe "favorite activities" do
    let (:user) { FactoryGirl.create(:user) }
    
    before do
      @activity.save
      user.favorite_activities.create!(activity_id: @activity.id)
    end
    
    it "should destroy favorite_activities for the activity" do
      favorite_activities = @activity.favorite_activities.dup
      @activity.destroy
      favorite_activities.should_not be_empty
      favorite_activities.each do |favorite_activity|
        Corner::FavoriteActivity.find_by_id(favorite_activity.id).should be_nil
      end
    end
    
  end
  
end
