class CampaignSerializer
  include JSONAPI::Serializer
  attributes :name, :image_url, :percentage_raised, :target_amount, :sector, :country, :investment_multiple
end
