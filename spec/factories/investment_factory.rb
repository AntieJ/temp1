FactoryBot.define do
  factory :campaign do
    name { Faker::Company.name }
    image_url { Faker::LoremFlickr.image(search_terms: ['company']) }
    target_amount { rand(100_000.0..999_999.99).round(2) }
    sector { Faker::Company.industry }
    country { Faker::Address.country_code }
    investment_multiple { rand(0.01..9.99).round(2) }
  end
end