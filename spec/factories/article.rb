FactoryGirl.define do
  factory :article do
    title "First Article"
    body "This is the newest article."
    user
  end
end