require "spec_helper"

describe Corner::LogTag do
  after(:all) { clear_all_databases }
  before do
    tag = FactoryGirl.create(:tag)
    @log_tag = Corner::LogTag.new(tag_id: tag.id, associated_id: 1)
  end
  
  subject { @log_tag }
  
  it { should respond_to(:tag_id) }
  it { should respond_to(:associated_id) }
  it { should respond_to(:type) }
  it { should respond_to(:tag) }
  it { should respond_to(:log) }
  its (:type) { should eq("Corner::LogTag") }
  it { should be_valid }

  it { should be_invalid_with_attribute_value(:tag_id, nil) }
  it { should be_invalid_with_attribute_value(:associated_id, nil) }
  it { should be_invalid_with_attribute_value(:type, "") }
  
end