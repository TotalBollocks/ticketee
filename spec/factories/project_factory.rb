FactoryGirl.define do
  factory :project do
    sequence(:name) {|n|"Example Project-#{n}"}
  end
end