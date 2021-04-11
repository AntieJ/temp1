FactoryBot.define do
  factory :investment do
    campaign
    amount { campaign.investment_multiple * rand(1..10) }
  end
end