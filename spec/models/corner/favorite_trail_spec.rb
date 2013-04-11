require 'spec_helper'

describe Corner::FavoriteTrail do
  let(:user) { FactoryGirl.create(:user) }
  let(:trail) { create_trail }
  before { @favorite_trail = user.favorite_trails.create(trail_id: trail.id) }
  subject { @favorite_trail }
  
  it { should be_valid }
  it { should respond_to(:user_id) }
  it { should respond_to(:trail_id) }
  it { should respond_to(:user) }
  it { should respond_to(:trail) }
  
  describe "when user_id is missing" do
    before { @favorite_trail.user_id = nil }
    it { should_not be_valid }
  end
  
  describe "when trail_id is missing" do
    before { @favorite_trail.trail_id = nil }
    it { should_not be_valid }
  end
  
  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Corner::FavoriteTrail.new(user_id: user.id, trail_id: trail.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end
end
