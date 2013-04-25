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
  it { should respond_to(:trail_id) }
  it { should respond_to(:activity_id) }
  it { should respond_to(:trail) }
  it { should respond_to(:activity) }
  
  it { should be_invalid_with_attribute_value(:trail_id, nil) }
  it { should be_invalid_with_attribute_value(:activity_id, nil) }
  
  describe "accessible attributes" do
    it "should not allow access to trail_id" do
      expect do
        Common::ActivityAssociation.new(trail_id: trail.id, activity_id: activity.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end
  
end
