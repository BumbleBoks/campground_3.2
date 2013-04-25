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

RSpec::Matchers.define :be_invalid_with_attribute_value do |attribute, value|
  match do |model|
    model.public_send("#{attribute}=", value)
    model.valid?.should eq(false)
  end
end
