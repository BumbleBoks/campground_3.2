# == Schema Information
#
# Table name: common_states
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Common::State do
  before { @state = Common::State.new(name: "Footate") }
  subject { @state }
  
  it { should respond_to(:name) }
  it { should be_valid }
  
  describe "without name" do
    before { @state.name = '' }
    it { should_not be_valid }
  end
  
  describe "with a duplicate name" do
    before do
      state_with_dup_name = @state.dup
      state_with_dup_name.save
    end
    
    it { should_not be_valid }
  end
  
end
