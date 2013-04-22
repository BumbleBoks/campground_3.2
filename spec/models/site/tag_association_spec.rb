require 'spec_helper'

describe Site::TagAssociation do
  after(:all) { clear_all_databases }
  before do
    tag = FactoryGirl.create(:tag)
    @tag_association = Site::TagAssociation.create(tag_id: tag.id, associated_id: 1, type: "log")
  end
  
  subject { @tag_association }
  
  it { should respond_to(:tag_id) }
  it { should respond_to(:associated_id) }
  it { should respond_to(:type) }
  it { should respond_to(:tag) }
  it { should be_valid }
  
  describe "without tag_id" do
    before { @tag_association.tag_id = nil }
    it { should_not be_valid }
  end
  
  describe "without associated_id" do
    before { @tag_association.associated_id = nil }
    it { should_not be_valid }
  end
  
  describe "without type" do
    before { @tag_association.type = "" }
    it { should_not be_valid }
  end

end
