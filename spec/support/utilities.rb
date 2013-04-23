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


def log_in(user)
  visit login_path
  fill_in "Login ID", with: user.login_id.upcase
  fill_in "Password", with: user.password
  click_button "Log in"        
  # session[:user_id] = user.id
end

# clears all tables besides the ones that are seeded
def clear_all_databases
  excluded_tables = ["schema_migrations", "common_states", "common_activities"]
  connection = ActiveRecord::Base.connection
  table_names = connection.tables.dup
  table_names.delete_if { |table_name| excluded_tables.include?(table_name) }
  
  table_names.each do |table_name|
    sql_command = "DELETE FROM #{table_name};"
    connection.execute sql_command
  end
end