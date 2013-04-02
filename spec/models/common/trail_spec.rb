# == Schema Information
#
# Table name: common_trails
#
#  id          :integer          not null, primary key
#  name        :string(75)       not null
#  length      :decimal(5, 2)
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  state_id    :integer
#

require 'spec_helper'

describe Common::Trail do
  let (:state) { FactoryGirl.create(:state) }
  before { @trail = state.trails.build(name: "Foo Trail", length: 10.0, 
    description: "It's an ideal foo trail") }
  subject { @trail }
  
  it { should respond_to(:name) }
  it { should respond_to(:length) }
  it { should respond_to(:description) }
  it { should respond_to(:state) }
  it { should respond_to(:activity_associations) }
  it { should respond_to(:activities) }
  it { should be_valid }
  
  describe "without name" do
    before { @trail.name = '' }
    it { should_not be_valid }
  end
  
  describe "with a non-numerical length" do
    before { @trail.length = 'abc' }
    it { should_not be_valid }
  end
  
  describe "same trail name with same state" do
    before do
      dup_trail = state.trails.build(name: @trail.name, length: 5.0)
      dup_trail.save
    end
    it "should not save" do
      expect { @trail.save }.not_to change(Common::Trail, :count)
    end
  end

  describe "same trail name with different state" do
    before do
      new_state = FactoryGirl.create(:state, name: "New State")
      dup_trail = new_state.trails.build(name: @trail.name, length: 5.0)
      dup_trail.save
    end
    it "should save" do
      expect { @trail.save }.to change(Common::Trail, :count).by(1)      
    end
  end  
  
end
