require 'rails_helper'

RSpec.describe "Api::V1::Investments", type: :request do
  describe "POST /create" do
    let(:campaign) { create(:campaign) }

    it "returns http success" do
      amount = campaign.investment_multiple * 2
      post "/api/v1/campaigns/#{campaign.id}/investments", params: { investment: { amount: amount } }

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to eq({
        'data' => {
          'id' => campaign.investments.last.id.to_s,
          'type' => 'investment',
          'attributes' => { 'amount' => amount.to_s }
        }
      })
      expect(campaign.investments.count).to eq 1
    end

    it "returns http unprocessable_entity if validations fail" do
      post "/api/v1/campaigns/#{campaign.id}/investments", params: { investment: { amount: 0 } }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)['message']).to eq ['Amount must be greater than 0.0']
      expect(campaign.investments.count).to eq 0
    end

    it "returns http not_found if campaign is missing" do
      post "/api/v1/campaigns/1/investments"

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)['message']).to eq "Couldn't find Campaign with 'id'=1"
    end
  end

end
