require "spec_helper"

describe Community::UpdatesHelper do
  describe "wrap long text" do
    before do
      @teststring = 'a'*60 
      @resultstring = 'a'*50 + "&#8203;" + 'a'*10
    end 
    it "should show two lines of text of default width" do
      wrap(@teststring).should eq(@resultstring)
    end
  end
end