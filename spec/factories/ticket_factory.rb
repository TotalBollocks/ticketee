FactoryGirl.define do
  factory :ticket do
    sequence(:title) {|n| "Ticket-#{n}"}
    sequence(:description) {|n| "Ticket Description-#{n}"}
    project
    user
  end
end