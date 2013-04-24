# == Schema Information
#
# Table name: site_tag_associations
#
#  id            :integer          not null, primary key
#  tag_id        :integer          not null
#  associated_id :integer          not null
#  type          :string(255)      not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'spec_helper'

describe Site::TagAssociation do
  after(:all) { clear_all_databases }
  before do
    tag = FactoryGirl.create(:tag)
    @tag_association = Site::TagAssociation.new(tag_id: tag.id, associated_id: 1, type: "log")
  end
  
  subject { @tag_association }
  
  it { should respond_to(:tag_id) }
  it { should respond_to(:associated_id) }
  it { should respond_to(:type) }
  it { should respond_to(:tag) }
  it { should be_valid }

  it { should be_invalid_with_attribute_value(:tag_id, nil) }
  it { should be_invalid_with_attribute_value(:associated_id, nil) }
  it { should be_invalid_with_attribute_value(:type, "") }

end
