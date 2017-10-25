FactoryBot.define do
  factory :post do
    sequence(:title) {|n| "Post#{n}"}
    ip "192.168.0.1"
    content "This is body for post"
    user nil
  end
end
