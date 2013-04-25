# == Schema Information
#
# Table name: common_states
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Common::State do
  before { @state = Common::State.new(name: "Footate") }
  subject { @state }
  
  it { should respond_to(:name) }
  it { should respond_to(:trails) }
  it { should be_valid }
  
  it { should be_invalid_with_attribute_value(:name, '') }
  
  describe "with a duplicate name" do
    before do
      state_with_dup_name = @state.dup
      state_with_dup_name.save
    end
    
    it { should_not be_valid }
  end  
  
end
