# == Schema Information
#
# Table name: common_trails
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  length      :decimal(, )
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe Common::Trail do
  before { @trail = Common::Trail.new(name: "Foo Trail", length: 10, 
    description: "It's an ideal foo trail") }
  subject { @trail }
  
  it { should respond_to(:name) }
  it { should respond_to(:length) }
  it { should respond_to(:description) }
  it { should respond_to(:state) }
  it { should respond_to(:activity) }
  it { should be_valid }
  
  describe "without name" do
    before { @trail.name = '' }
    it { should_not be_valid }
  end
  
  describe "with a non-numerical length" do
    before { @trail.length = 'abc' }
    it { should_not be_valid }
  end
end
