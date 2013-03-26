FactoryGirl.define do
  factory :user do
    sequence(:login_id) {|n| "foo#{n}" }
    name "The Foo"
    password "1foobar"
    password_confirmation "1foobar"
    email {"#{login_id}@example.com"}
    
    factory :admin do
      admin true
    end
  end
end    
