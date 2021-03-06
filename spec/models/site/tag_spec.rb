# == Schema Information
#
# Table name: site_tags
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Site::Tag do
  after(:all) { clear_all_databases }
  before { @tag = Site::Tag.new(name: "test") }
  subject { @tag }
  
  it { should respond_to(:name) }
  it { should respond_to(:tag_associations) }
  it { should be_valid }
  
  it { should be_invalid_with_attribute_value(:name, nil) }
  
  describe "with duplicate name" do
    before do
      tag_with_same_name = @tag.dup
      tag_with_same_name.name.upcase!
      tag_with_same_name.save
    end
    it { should_not be_valid }
  end
  
  describe "with invalid names" do
    invalid_names = ["abc765", "$a#b?3c", "%abc", "b@ca<}", "!/1*abc", "a bc"]    
    invalid_names.each do |name|
      it { should be_invalid_with_attribute_value(:name, name) }
    end
  end
  
  describe "with a long name" do
    before { @tag.name = "t"*21 }
    it { should_not be_valid }
  end
  
end
