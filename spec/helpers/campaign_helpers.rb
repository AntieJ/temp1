module CampaignHelpers
  def serialized_campaigns(campaigns)
    campaigns.map { |campaign|
      {
        'id' => campaign.id.to_s,
        'type' => 'campaign',
        'attributes' => {
          'name' => campaign.name,
          'image_url' => campaign.image_url,
          'country' => campaign.country,
          'sector' => campaign.sector,
          'percentage_raised' => campaign.percentage_raised,
          'investment_multiple' => campaign.investment_multiple,
          'target_amount' => campaign.target_amount
        }.as_json
      }
    }
  end
end
