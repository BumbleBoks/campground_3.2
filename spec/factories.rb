FactoryGirl.define do
  factory :user do
    sequence(:login_id) {|n| "foo#{n}" }    
    email "#{login_id}@example.com"
    name "The Foo"
    password "1foobar"
    password_confirmation "1foobar"
    
    factory :admin do
      admin true
    end
  end
end    
