# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

Campaign.delete_all
Investment.delete_all

30.times do
  Campaign.create({
    name: Faker::Company.name,
    image_url: Faker::LoremFlickr.image(search_terms: ['company']),
    target_amount: rand(100_000.0..999_999.99).round(2),
    sector: Faker::Company.industry,
    country: Faker::Address.country_code,
    investment_multiple: rand(0.01..9.99).round(2),
  })
end