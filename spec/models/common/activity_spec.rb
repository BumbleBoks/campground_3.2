# == Schema Information
#
# Table name: common_activities
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Common::Activity do
  before { @activity = Common::Activity.new(name: "Footivity") }
  subject { @activity }
  
  it { should respond_to(:name) }
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
  
end
