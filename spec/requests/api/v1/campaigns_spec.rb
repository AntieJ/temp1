require 'rails_helper'

RSpec.describe "Api::V1::Campaigns", type: :request do
  describe "GET /index" do
    let!(:campaign_a) { create(:campaign, sector: 'Health Care', investments_count: 0) }
    let!(:campaign_b) { create(:campaign, sector: 'Health Care', investments_count: 5) }
    let!(:campaign_c) { create(:campaign, sector: 'Finance', investments_count: 10) }
    let!(:campaign_d) { create(:campaign, sector: 'Finance', investments_count: 12) }

    it "returns http success" do
      campaigns = [campaign_a, campaign_b, campaign_c, campaign_d]
      get "/api/v1/campaigns"

      expect(response).to have_http_status(:success)
      parsed_body = JSON.parse(response.body)
      expect(parsed_body['data']).to contain_exactly(*serialized_campaigns(campaigns))
    end

    it "filters by sector" do
      campaigns = [campaign_a, campaign_b]
      get "/api/v1/campaigns", params: { sector: 'Health Care' }

      expect(response).to have_http_status(:success)
      parsed_body = JSON.parse(response.body)
      expect(parsed_body['data']).to contain_exactly(*serialized_campaigns(campaigns))
    end

    it "filters by investments_count" do
      campaigns = [campaign_b, campaign_c]
      get "/api/v1/campaigns", params: { investments_count: { from: 4, to: 11 } }

      expect(response).to have_http_status(:success)
      parsed_body = JSON.parse(response.body)
      expect(parsed_body['data']).to contain_exactly(*serialized_campaigns(campaigns))
    end
  end

end
