require 'spec_helper'

describe Site::Tag do
  after(:all) { clear_all_databases }
  before { @tag = Site::Tag.new(name: "test") }
  subject { @tag }
  
  it { should respond_to(:name) }
  it { should respond_to(:tag_associations) }
  it { should be_valid }
  
  describe "without name" do
    before { @tag.name = "" }
    it { should_not be_valid }
  end
  
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
      before { @tag.name = name }
      it { should_not be_valid }
    end
  end
  
  describe "with a long name" do
    before { @tag.name = "t"*21 }
    it { should_not be_valid }
  end
  
end
