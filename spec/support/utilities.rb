RSpec::Matchers.define :has_page_title do |title|
  match do |page|
    page.html.match(/<title>(.*)<\/title>/)[1].to_s.should eq(title) 
  end
end