FactoryGirl.define do
  sequence(:random_string) do |n|
    alphabets = "abcdefghijklmnopqrstuvwxyz"
    len = rand(1..10)
    random_string = String.new
    len.times do 
      random_string << alphabets[rand(0..25)]
    end
    random_string    
  end

  factory :user, aliases: [:author] do
    sequence(:login_id) { |n| "foo#{n}" }    
    email { "#{login_id}@example.com" }
    name "The Foo"
    password "1foobar"
    password_confirmation "1foobar"
    
    factory :admin do
      admin true
    end
  end
  
  factory :state, class: Common::State do
    sequence(:name) { |n| "Foo#{n} State" }
  end
  
  factory :activity, class: Common::Activity do
    sequence(:name) { |n| "Foo#{n} Activity" }
  end

  factory :trail, class: Common::Trail do
    name "Foo Trail"
    length 10
    description "This is a great trail"
    state
    # activities
  end
  
  factory :update, class: Community::Update do
    content "Lorem ipsum"
    author
    trail
  end

  factory :log, class: Corner::Log do
    title "Title"
    content "Lorem ipsum"
    user
  end
  
  factory :tag, class: Site::Tag do
    name { generate(:random_string) }
  end
  
end    
