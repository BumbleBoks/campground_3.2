RSpec::Matchers.define :has_page_title do |title|
  match do |page|
    page.html.match(/<title>(.*)<\/title>/)[1].to_s.should eq(title) 
  end
end

def log_in(user)
  visit login_path
  fill_in "Login ID", with: user.login_id.upcase
  fill_in "Password", with: user.password
  click_button "Log in"        
  # session[:user_id] = user.id
end