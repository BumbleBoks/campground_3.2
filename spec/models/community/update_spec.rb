# == Schema Information
#
# Table name: community_updates
#
#  id         :integer          not null, primary key
#  content    :text             not null
#  author_id  :integer          not null
#  trail_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Community::Update do
  let (:user) { FactoryGirl.create(:user) }
  let (:trail) { create_trail }
  before { @update = user.updates.build(content: "New Update!", trail_id: trail.id) }
  subject { @update }
  
  it { should be_valid }
  it { should respond_to(:content) }
  it { should respond_to(:trail_id) }
  it { should respond_to(:author_id) }
  it { should respond_to(:author) }
  it { should respond_to(:trail) }
  
  describe "without content" do
    before { @update.content = "" }
    it { should_not be_valid }
  end
  
  describe "without trail_id" do
    before { @update.trail_id = "" }
    it { should_not be_valid }
  end
  
  describe "without author_id" do
    before { @update.author_id = "" }
    it { should_not be_valid }
  end
  
  describe "accessible attributes" do
    it "should not allow access to author_id" do
      expect do
        Community::Update.new(content: "New Update!", author_id: user.id, trail_id: trail.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end
  
  describe "very long content" do
    before { @update.content = "a"*501 }
    it { should_not be_valid }
  end
end
