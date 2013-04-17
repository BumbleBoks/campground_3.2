# test for layout with user not logged in - should be run for all pages  
shared_examples_for "all pages without logging in" do
  it { should have_css("#user_individual") }
  it { should have_css("#user_community") }
  it { should have_css("#user_dynamic") }
  it { should have_link("About", href: about_path) }
  it { should have_link("Contact", href: contact_path) }    
  it { should have_link("Join", href: join_path) }
  it { should have_link("Log in", href: login_path) }
  it { should_not have_link("Profile") }
  it { should_not have_link("Log out") }
end

# test for layout with user logged in - should be run for all pages  
shared_examples_for "all pages for logged in user" do
  it { should have_css("#user_individual") }
  it { should have_css("#user_community") }
  it { should have_css("#user_dynamic") }
  it { should have_link("About", href: about_path) }
  it { should have_link("Contact", href: contact_path) }    
  it { should_not have_link("Join") }
  it { should_not have_link("Log in") }
  # it { should have_link("Profile", user_path(user)) }
  it { should have_link("Log out", logout_path) }
end

# test for home page when user is not logged in
shared_examples_for "home page when not logged in" do
  it { should have_page_title("Campground") }
  it { should have_selector('h2', text: "Welcome to Campground") }       
end

RSpec::Matchers.define :have_page_title do |title|
  match do |page|
    html_element_raw = page.html.match(/<title>(.*)<\/title>/).to_s  
    html_element_without_title = html_element_raw.gsub(/<(\/)*(title)>/, '')
    html_text = html_element_without_title.gsub(/(&#x27;)/, "'")
    # print html_text
    html_text.should eq(title) 
  end
end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    page.should have_selector('div.alert.alert-error', text: message)
  end
end

RSpec::Matchers.define :have_field_with_name_and_value do |name, value|
  match do |page|
    find_field(name).value.should eq(value)
  end
end

RSpec::Matchers.define :have_optgroup_with_label_and_text do |label, text|
  match do |page|
    page.should have_selector("optgroup[label='#{label}']", text: text)
  end
end

def log_in(user)
  visit login_path
  fill_in "Login ID", with: user.login_id.upcase
  fill_in "Password", with: user.password
  click_button "Log in"        
  # session[:user_id] = user.id
end

def clear_all_databases
  Community::Update.delete_all
  Corner::FavoriteTrail.delete_all
  Corner::FavoriteActivity.delete_all
  User.delete_all
end