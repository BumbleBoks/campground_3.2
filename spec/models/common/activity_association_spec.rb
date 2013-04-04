# == Schema Information
#
# Table name: common_activity_associations
#
#  id          :integer          not null, primary key
#  activity_id :integer          not null
#  trail_id    :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe Common::ActivityAssociation do
  let (:activity) { FactoryGirl.create(:activity) }
  let (:state) { FactoryGirl.create(:state) }
  let (:trail) { FactoryGirl.create(:trail, state_id: state.id) }
  let (:activity_association) { trail.activity_associations.build(activity_id: activity.id) }
  
  subject { activity_association }
  it { should be_valid }
  
  describe "when trail id is not present" do
    before { activity_association.trail_id = nil }
    it { should_not be_valid }
  end
  
  describe "when activity id is not present" do
    before { activity_association.activity_id = nil }
    it { should_not be_valid }
  end
  
  describe "accessible attributes" do
    it "should not allow access to trail_id" do
      expect do
        Common::ActivityAssociation.new(trail_id: trail.id, activity_id: activity.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end
  
end
