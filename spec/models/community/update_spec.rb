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
  
  it { should be_invalid_with_attribute_value(:content, nil) }
  it { should be_invalid_with_attribute_value(:trail_id, nil) }
  it { should be_invalid_with_attribute_value(:author_id, nil) }
  it { should be_invalid_with_attribute_value(:content, "a"*501) }
  
  describe "accessible attributes" do
    it "should not allow access to author_id" do
      expect do
        Community::Update.new(content: "New Update!", author_id: user.id, trail_id: trail.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end
end
